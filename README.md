# gnupg hardcopy

Generates a full hardcopy from a key, with checksomes to help with disaster-recovery

That's the same goal as the `paperkey` tool, but (imho) better and more resilient :-)

# usage

Step 1 : generate a hardcopy of your key :

	./hardcopy.sh KEYID > output.txt

Step 2 : create a rich-text document by copying the generated text 2-3 times

Step 3 : select a different font for each copy (to help discern zero vs capital-o, etc)

Step 4 : print a couple copies on a laser printer using quality paper

Step 5 : keep a copy at home, and give/send the other to a trustworthy person

Step 6 : Relax :-)

# example

Below is a sample output, where i suppressed some lines with `...` to shorten it.

You can see all that is produced in the output, especially the "per line checksums" in the raw blocks (to be removed before import, of course) which tremendously help when checking input, in the event of disaster recovery.

The dumped private key is encrypted with the passphrase, so that is the reason the passphrase is dumped in cleartext too !

	Key information:

	pub   4096R/0xAA284149E95278BF 2017-04-29 [expire : 2017-04-30]
	      Empreinte de la clef = 4B8D 9EA0 4F0E D281 3A6C  9F65 AA28 4149 E952 78BF
	uid                [  ultime ] i am nobody <nobody@example.com>
	sub   4096R/0xCBC2C7ECD728A54A 2017-04-29 [expire : 2017-04-30]
	      Empreinte de la clef = 80BE 2B14 99CA 0625 17F6  FCBD CBC2 C7EC D728 A54A

	sec   4096R/0xAA284149E95278BF 2017-04-29 [expire : 2017-04-30]
	      Empreinte de la clef = 4B8D 9EA0 4F0E D281 3A6C  9F65 AA28 4149 E952 78BF
	uid                            i am nobody <nobody@example.com>
	ssb   4096R/0xCBC2C7ECD728A54A 2017-04-29 [expire : 2017-04-30]
	      Empreinte de la clef = 80BE 2B14 99CA 0625 17F6  FCBD CBC2 C7EC D728 A54A

	Passphrase dump:

	00000000  6e 6f 62 6f 64 79                                 |nobody|
	00000006

	Revocation certificate (ascii with control checksums):

	-----BEGIN PGP PUBLIC KEY BLOCK-----	3675205589 37
	Comment: A revocation certificate should follow	1174818075 48
		3515105045 1
	iQIfBCABCgAJBQJZBLitAh0CAAoJEKooQUnpUni/HfMP/j/PMsJvs1ynGgAPCQmV	4244027488 65
	IgoQroP6TKAsgBZeC7hYMVhky285pqa1EMc8EXjgQP+fl/XQI0LUbpLXsnSDzZrl	3634028244 65
	25ncHIBjjS8Bgjad6tY6l5qWUTwG8hOf/KYcy/9YRRNMQir3+xbsGzTpysNJYOOf	3581115244 65
	...
	jRmyum1AlbVFjKRgg3Qdfz/yFFM2Iqf99IXFB9iM1ANZCCtOZgz8SqR1vLq1wS8e	646648826 65
	aWad38m9U4bWVWVEhb1g3FRKoMVJI/c4+Rf1iXdOV4w3FhdnfUY1nYdwDA7CN7wQ	2258424165 65
	QX7CbUaTP6PGp45PG2DvdRx3sJ9Dtae1Rp6eA6OcNglFdFhHeI3lcYxEq6mEIWED	4062787028 65
	M7oJp/blUwbGom+aPc+epOje	1213640294 25
	=lf6d	3377414758 6
	-----END PGP PUBLIC KEY BLOCK-----	498750189 35

	Revocation certificate (hexdump of raw ascii):

	00000000  2d 2d 2d 2d 2d 42 45 47  49 4e 20 50 47 50 20 50  |-----BEGIN PGP P|
	00000010  55 42 4c 49 43 20 4b 45  59 20 42 4c 4f 43 4b 2d  |UBLIC KEY BLOCK-|
	00000020  2d 2d 2d 2d 0a 43 6f 6d  6d 65 6e 74 3a 20 41 20  |----.Comment: A |
	00000030  72 65 76 6f 63 61 74 69  6f 6e 20 63 65 72 74 69  |revocation certi|
	00000040  66 69 63 61 74 65 20 73  68 6f 75 6c 64 20 66 6f  |ficate should fo|
	00000050  6c 6c 6f 77 0a 0a 69 51  49 66 42 43 41 42 43 67  |llow..iQIfBCABCg|
	00000060  41 4a 42 51 4a 5a 42 4c  69 74 41 68 30 43 41 41  |AJBQJZBLitAh0CAA|
	...
	00000320  0a 4d 37 6f 4a 70 2f 62  6c 55 77 62 47 6f 6d 2b  |.M7oJp/blUwbGom+|
	00000330  61 50 63 2b 65 70 4f 6a  65 0a 3d 6c 66 36 64 0a  |aPc+epOje.=lf6d.|
	00000340  2d 2d 2d 2d 2d 45 4e 44  20 50 47 50 20 50 55 42  |-----END PGP PUB|
	00000350  4c 49 43 20 4b 45 59 20  42 4c 4f 43 4b 2d 2d 2d  |LIC KEY BLOCK---|
	00000360  2d 2d 0a                                          |--.|
	00000363

	Encrypted secret key (ascii with control checksums):

	-----BEGIN PGP PRIVATE KEY BLOCK-----	405765863 38
		3515105045 1
	lQdGBFkEtLoBEACytClukcKcmuUEE0bLC5PwKChkGyBG4WPxvrBX0JHH24d5pwhM	2358207765 65
	zhxaPnvu1rHDq5s6+qJT5H2+PzPoSBp0PauJ4nLj0qHiOPUygTXI0rvYsSV5HRxl	126766982 65
	0T6GIWNtEnA5/y4ZZHOj8WXXqtcBN0+quaOdXOmCzn4tzm0B+Z8voyxLHY84WY2w	942286014 65
	...
	aAOro3Arz2gJRiXez83unnMbxxAIVZvmBFAsJf4VJ1VYPp1o/Kx0hb7F7nUDL7yg	1588600492 65
	xI3fZyxcUf/EWDtjfBhKMy9PXU6SRkSEnaDp3cX55fVjIOeo9kJrGGqhpzR0iq7j	1075548066 65
	ecSBD5MA4kHnLZr0JepcKMQY0a/flOOaRlpQUbiA5byqSbAlI4D1PM/fq7E=	925051626 61
	=3m4C	803832438 6
	-----END PGP PRIVATE KEY BLOCK-----	101326596 36

	Encrypted secret key (hexdump of raw ascii):

	00000000  2d 2d 2d 2d 2d 42 45 47  49 4e 20 50 47 50 20 50  |-----BEGIN PGP P|
	00000010  52 49 56 41 54 45 20 4b  45 59 20 42 4c 4f 43 4b  |RIVATE KEY BLOCK|
	00000020  2d 2d 2d 2d 2d 0a 0a 6c  51 64 47 42 46 6b 45 74  |-----..lQdGBFkEt|
	00000030  4c 6f 42 45 41 43 79 74  43 6c 75 6b 63 4b 63 6d  |LoBEACytClukcKcm|
	00000040  75 55 45 45 30 62 4c 43  35 50 77 4b 43 68 6b 47  |uUEE0bLC5PwKChkG|
	00000050  79 42 47 34 57 50 78 76  72 42 58 30 4a 48 48 32  |yBG4WPxvrBX0JHH2|
	...
	000019d0  44 35 4d 41 34 6b 48 6e  4c 5a 72 30 4a 65 70 63  |D5MA4kHnLZr0Jepc|
	000019e0  4b 4d 51 59 30 61 2f 66  6c 4f 4f 61 52 6c 70 51  |KMQY0a/flOOaRlpQ|
	000019f0  55 62 69 41 35 62 79 71  53 62 41 6c 49 34 44 31  |UbiA5byqSbAlI4D1|
	00001a00  50 4d 2f 66 71 37 45 3d  0a 3d 33 6d 34 43 0a 2d  |PM/fq7E=.=3m4C.-|
	00001a10  2d 2d 2d 2d 45 4e 44 20  50 47 50 20 50 52 49 56  |----END PGP PRIV|
	00001a20  41 54 45 20 4b 45 59 20  42 4c 4f 43 4b 2d 2d 2d  |ATE KEY BLOCK---|
	00001a30  2d 2d 0a                                          |--.|
	00001a33
