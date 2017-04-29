#! /bin/bash

KEY="${1}"
TMP=""

# exit on any error
set -o errexit

# exit on pipefail
set -o pipefail

# abort on unitialized variable
set -o nounset

# util function
function cleanup {
	if [[ -n "${TMP}" ]]
	then
		echo "Cleaning up ${TMP}" >&2
		rm -f "${TMP}"
	else
		echo "Nothing to clean up" >&2
	fi
}

# trap for cleanup in case of error
trap "cleanup" INT TERM EXIT

# check arguments
if [[ -z "${KEY}" ]]
then
	echo "Usage info : ${0} NUMERICAL_KEY_ID > hardcopy.txt" >&2
	exit 1
fi

# ask for passphrase to save it in hardcopy
echo "==== STEP 1 : ask for your passphrase to print it to hardcopy" >&2
read -r -p "Please enter your passphrase so it can be appened to the hardcopy : " PASS

# generate a temporary file for the revocation part
echo "==== STEP 2 : generate a revocation certificate" >&2
TMP="$(tempfile)"
gpg --no-use-agent --passphrase "${PASS}" --gen-revoke "${KEY}" > "${TMP}"

# check that we actually generated something (if user aborts in gpg, it exits with 0)
if [[ ! -s "${TMP}" ]]
then
	echo "==== ABORTING: No revocation certificate generated." >&2
	exit 1
fi

# display key information
echo "==== STEP 3 : generate hardcopy" >&2

echo -e "\nKey information:\n"
gpg -k --fingerprint "${KEY}"
gpg -K --fingerprint "${KEY}"

echo -e "\nPassphrase dump:\n"
echo -n "${PASS}" | hd

echo -e "\nRevocation certificate (ascii with control checksums):\n"
cat "${TMP}" | while read n; do echo -e -n "${n}\t"; echo "${n}"|cksum; done

echo -e "\nRevocation certificate (hexdump of raw ascii):\n"
cat "${TMP}" | hd

echo -e "\nEncrypted secret key (ascii with control checksums):\n"
gpg --export-secret-key --armor "${KEY}" | while read n; do echo -e -n "${n}\t"; echo "${n}" | cksum; done

echo -e "\nEncrypted secret key (hexdump of raw ascii):\n"
gpg --export-secret-key --armor "${KEY}" | hd

# cleanup
echo "==== STEP 4 : finished, now cleanup" >&2
exit 0
