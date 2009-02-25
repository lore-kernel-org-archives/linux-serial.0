From: Niels de Vos <niels.devos@wincor-nixdorf.com>
Subject: Re: Regarding PATCH for ITE887x Serial
Date: Wed, 25 Feb 2009 09:57:19 +0100
Message-ID: <49A507EF.8010502@wincor-nixdorf.com>
References: <499E6C09.4090108@yahoo.com> <499E6FC7.506@wincor-nixdorf.com> <499E77CE.4010008@yahoo.com> <499E81D3.4080107@wincor-nixdorf.com> <499E84AE.7050209@yahoo.com>   <499E86D2.1030507@wincor-nixdorf.com> <499F120A.8050902@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBD2E5952C79F0F68E1236E54"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mxpdbe2.wincor-nixdorf.com ([80.154.98.130]:57902 "EHLO
	mxpdbe2.wincor-nixdorf.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757141AbZBYJC5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Feb 2009 04:02:57 -0500
Received: from cfpdbx1.wincor-nixdorf.com (unknown [10.254.32.9])
	by mxpdbe2.wincor-nixdorf.com (Postfix) with ESMTP id 900A4108095
	for <linux-serial@vger.kernel.org>; Wed, 25 Feb 2009 09:02:37 +0000 (GMT)
In-Reply-To: <499F120A.8050902@yahoo.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Christopher <kirian100@yahoo.com>
Cc: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBD2E5952C79F0F68E1236E54
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Christopher,

Christopher wrote:
> I have tried:
>=20
> Debian 5
> Fedora Live CD 11
> Ubuntu 8.10
> CentOS 5.2 custom kernel from kernel.org with almost all modules enable=
d

Great testing. The Fedora Live CD 11 contains a very recent kernel
and should recognize all known (at least to me) ITE-chips.


> Nothing recognizes it. All output is same on lspci.

Not only lspci is important, also the output of dmesg (grep for tty)
and the file /proc/ioports.


> I have CCed linux-serial@vger.kernel.org as well with output of lspci -=
vv
>=20
> 02:0e.0 Serial controller: PLX Technology, Inc. Unknown device 9016 (re=
v
> 01) (prog-if 02 [16550])
>        Subsystem: Unknown device 544e:0008
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbor=
t-
> <TAbort- <MAbort- >SERR- <PERR-
>        Interrupt: pin A routed to IRQ 169
>        Region 0: I/O ports at 2440 [disabled] [size=3D64]
>        Region 1: I/O ports at 2490 [disabled] [size=3D16]
>        Region 2: I/O ports at 2480 [disabled] [size=3D16]
>        Region 3: Memory at f2003000 (32-bit, non-prefetchable)
> [disabled] [size=3D4K]
>        Region 4: Memory at f2002000 (32-bit, non-prefetchable)
> [disabled] [size=3D4K]
>        Region 5: Memory at f2001000 (32-bit, non-prefetchable)
> [disabled] [size=3D4K]

Compared this to one of the ITE-chips here. I'm not convinced this is
a chip by ITE. Can you tell me the exact type of it887x (x=3D...)?


> My main server runs Linux 2.6.18-92.1.22.el5 #1 SMP Tue Dec 16 12:03:43=

> EST 2008 i686 i686 i386 GNU/Linux (CentOS 5.2)
>=20
> I have attached the "drivers" they gave me for 2.6 kernel supposedly.
> Although i believe its for the 2.4 as the readme that it has its for 2.=
4
> kernel.

This rough patch was available for kernel-2.4. As nobody But ITE could
provide us (Wincor-Nixdorf) with drivers for kernel-2.6. I was assigned
to implement the serial-part of the driver in 8250_pci.c.

Hope that helps,
Niels


>=20
> Thanks
>=20
> Regards,
> Chris
>=20
> Niels de Vos wrote:
>> Christopher wrote:
>> =20
>>> Im currently compiling my own kernel use guide from
>>> http://howtoforge.com/kernel_compilation_centos
>>>    =20
>>
>> Site is down atm... Don't refresh your browser ;)
>>
>>
>> =20
>>> Using the latest kernel from kernel.org and my current .config
>>>
>>> You believe this will have the drivers needed?
>>>    =20
>>
>> Yes, that should work.
>>
>> Please send me a little update on you success (or not).
>>
>> Thanks,
>> Niels
>>
>>
>> =20
>>> Thanks
>>>
>>> Chris
>>>
>>> Niels de Vos wrote:
>>>   =20
>>>> Christopher wrote:
>>>> =20
>>>>     =20
>>>>> I have tried to install the kernel as you said:
>>>>>
>>>>> [root@Server ~]# rpm -ivh --nodeps
>>>>> http://kojipkgs.fedoraproject.org/packages/kernel/2.6.29/0.137.rc5.=
git4.fc11/i586/kernel-2.6.29-0.137.rc5.git4.fc11.i586.rpm
>>>>>
>>>>>
>>>>>
>>>>> Retrieving
>>>>> http://kojipkgs.fedoraproject.org/packages/kernel/2.6.29/0.137.rc5.=
git4.fc11/i586/kernel-2.6.29-0.137.rc5.git4.fc11.i586.rpm
>>>>>
>>>>>
>>>>>
>>>>> Preparing...              =20
>>>>> ###########################################
>>>>> [100%]
>>>>>   1:kernel                 ########################################=
###
>>>>> [100%]
>>>>> WARNING: No module ehci-hcd found for kernel
>>>>> 2.6.29-0.137.rc5.git4.fc11.i586, continuing anyway
>>>>> WARNING: No module ohci-hcd found for kernel
>>>>> 2.6.29-0.137.rc5.git4.fc11.i586, continuing anyway
>>>>> WARNING: No module uhci-hcd found for kernel
>>>>> 2.6.29-0.137.rc5.git4.fc11.i586, continuing anyway
>>>>> WARNING: No module ata_piix found for kernel
>>>>> 2.6.29-0.137.rc5.git4.fc11.i586, continuing anyway
>>>>> Usage: new-kernel-pkg [-v] [--mkinitrd] [--rminitrd]
>>>>>       [--initrdfile=3D<initrd-image>] [--depmod] [--rmmoddep]
>>>>>       [--kernel-args=3D<args>] [--remove-args=3D<args>]
>>>>>       [--banner=3D<banner>] [--multiboot=3Dmultiboot]
>>>>>       [--mbargs=3Dmbargs] [--make-default]
>>>>>       <--install | --remove | --update> <kernel-version>
>>>>>       (ex: new-kernel-pkg --mkinitrd --depmod --install 2.4.7-2)
>>>>> error: %posttrans(kernel-2.6.29-0.137.rc5.git4.fc11.i586) scriptlet=

>>>>> failed, exit status 1
>>>>> [root@Server ~]#
>>>>>
>>>>> It fails to install the kernel.
>>>>>            =20
>>>> Hmm, same here... Tried to create the initrd with mkinitrd but it wo=
n't
>>>> detect my AHCI-drives... Unable to boot the system completely.
>>>>
>>>> You might be able to create a working initrd manually, after install=
ing
>>>> the kernel with 'rpm -ivh --nodeps --noscripts ...'. However, easies=
t
>>>> would be to update the mkinitrd-package to the required version and
>>>> install the kernel after that.
>>>>
>>>> Alternatively you might try an older version of the kernel 2.6.23+. =
Or
>>>> download and try with a Fedora-10-Live CD/USB.
>>>>
>>>> Hope that helps,
>>>> Niels
>>>>
>>>>
>>>> =20
>>>>     =20
>>>>> Any ideas?
>>>>>
>>>>> Thanks
>>>>>
>>>>> Niels de Vos wrote:
>>>>>          =20
>>>>>> Hello Chris,
>>>>>>
>>>>>> Christopher wrote:
>>>>>> =20
>>>>>>              =20
>>>>>>> I have bought off ebay the 8port Serial DB9 adapter with ITE8871
>>>>>>> chipset
>>>>>>> and my CentOS5.1 with Kernel 2.6.18-92.1.22.el5 does not seem to
>>>>>>> recognize it.
>>>>>>>                        =20
>>>>>> ITE887x hardware gets recognised with kernel 2.6.23 and newer.
>>>>>> RHEL has
>>>>>> not included a backport for this driver (so CentOS also didn't).
>>>>>>
>>>>>> I know some people use a Fedora kernel on CentOS. You can download=

>>>>>> the
>>>>>> most recent version from here:
>>>>>> <http://koji.fedoraproject.org/koji/packageinfo?packageID=3D8>
>>>>>>
>>>>>> I don't know if the RPM just installs like that (probably not).
>>>>>> But for
>>>>>> some testing it should be okay to install the RPM with
>>>>>> 'rpm -ivh --nodeps kernel....rpm'.
>>>>>>
>>>>>> If the ports still don't work as expected, please re-post the
>>>>>> output of
>>>>>> 'lspci -vv' and the relevant parts from 'dmesg' to me with a CC to=

>>>>>> linux-serial@vger.kernel.org.
>>>>>>
>>>>>> Good luck :)
>>>>>> Niels
>>>>>>
>>>>>>
>>>>>> =20
>>>>>>              =20
>>>>>>> lspci -vv shows
>>>>>>>
>>>>>>> 02:0e.0 Serial controller: PLX Technology, Inc. Unknown device 90=
16
>>>>>>> (rev
>>>>>>> 01) (prog-if 02 [16550])
>>>>>>>        Subsystem: Unknown device 544e:0008
>>>>>>>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop=
-
>>>>>>> ParErr- Stepping- SERR+ FastB2B-
>>>>>>>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
>>>>>>>           =20
>>>>>>>> TAbort-
>>>>>>>>              =20
>>>>>>> <TAbort- <MAbort- >SERR- <PERR-
>>>>>>>        Interrupt: pin A routed to IRQ 169
>>>>>>>        Region 0: I/O ports at 2440 [disabled] [size=3D64]
>>>>>>>        Region 1: I/O ports at 2490 [disabled] [size=3D16]
>>>>>>>        Region 2: I/O ports at 2480 [disabled] [size=3D16]
>>>>>>>        Region 3: Memory at f2003000 (32-bit, non-prefetchable)
>>>>>>> [disabled] [size=3D4K]
>>>>>>>        Region 4: Memory at f2002000 (32-bit, non-prefetchable)
>>>>>>> [disabled] [size=3D4K]
>>>>>>>        Region 5: Memory at f2001000 (32-bit, non-prefetchable)
>>>>>>> [disabled] [size=3D4K]
>>>>>>>
>>>>>>>
>>>>>>> I saw online in a post from KernelTrap you wrote at
>>>>>>> http://kerneltrap.org/mailarchive/linux-kernel/2007/3/26/70429 th=
at
>>>>>>> you
>>>>>>> created a patch for this.
>>>>>>>
>>>>>>> Since i have no idea from C language and how to load the driver c=
an
>>>>>>> you
>>>>>>> please let me know what to do to properly load the driver?
>>>>>>>
>>>>>>> Thanks a lot for your time and assistance.
>>>>>>>
>>>>>>> Chris
>>>>>>>                        =20
>>>>>>                  =20
>>>>        =20
>>
>>
>>  =20
>=20



--------------enigBD2E5952C79F0F68E1236E54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFJpQfv5KAkGQPO/QoRAvkhAJ9A9VkfO+N0Lpqb1Ur1K8gTBw9BRgCggQq8
b+CimYX1DJZ+3daLq5QzwBk=
=rH07
-----END PGP SIGNATURE-----

--------------enigBD2E5952C79F0F68E1236E54--
