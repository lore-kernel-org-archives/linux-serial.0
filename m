From: "Lu.Jiang" <lu.jiang@windriver.com>
Subject: Re: [v2] serial_core:recognize invalid pointer from userspace
Date: Fri, 11 Mar 2016 10:30:57 +0800
Message-ID: <56E22DE1.80101@windriver.com>
References: <1457579843-29676-1-git-send-email-lu.jiang@windriver.com>
 <1457579843-29676-2-git-send-email-lu.jiang@windriver.com>
 <20160310033435.GA28983@kroah.com> <56E0FE77.1020303@windriver.com>
 <20160310134647.7053a520@lxorguk.ukuu.org.uk>
Reply-To: <lu.jiang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160310134647.7053a520@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2016=E5=B9=B403=E6=9C=8810=E6=97=A5 21:46, One Thousand Gnomes wrote=
:
>> When userspace get setting with TIOCGSERIAL,
>>
>> 1.On 64bit kernel + 32bit rootfs, compat ioctl code use 0xffffffff t=
o
>> mark invalid conversion.
> Start at the beginning. What is being passed back and forth that caus=
es
> the problem. What memory address does your uart have ?

In fs/compat_ioctl.c, serial_struct_ioctl() use following code for=20
convert a 64bit pointer into 32bit userspace pointer

         if (cmd =3D=3D TIOCGSERIAL && err >=3D 0) {
                 if (copy_in_user(ss32, ss, offsetof(SS32, iomem_base))=
 ||
                     get_user(iomem_base, &ss->iomem_base))
                         return -EFAULT;
                 base =3D (unsigned long)iomem_base  >> 32 ?
                         0xffffffff : (unsigned)(unsigned long)iomem_ba=
se;

If iomem_base exceed 4G, TIOCGSERIAL didn't return right value for=20
iomem_base.

it  use following code to covert 32bit to 64bit.
         if (cmd =3D=3D TIOCSSERIAL) {
                 if (copy_in_user(ss, ss32, offsetof(SS32, iomem_base))=
 ||
                     get_user(udata, &ss32->iomem_base))
                         return -EFAULT;
                 iomem_base =3D compat_ptr(udata);


static inline void __user *compat_ptr(compat_uptr_t uptr)
{
         return (void __user *)(unsigned long)uptr;
}

You can see userspace application didn't get valid iomem_base via=20
TIOCGSERAIL.
When issuing TIOCSSERIAL, application can not provide a workable value=20
for kernel. It means TIOCSSERIAL can not work.

Typical serial setting application setserial is depend on those 2 ioctl=
s.

>
>> 2.On 32bit kernel with 64bit physical address, uart_get_info() in
>> serial_core will truncate a 64bit address into 32bit pointer with
>> following code:
>>       retinfo->iomem_base      =3D (void *)(unsigned long)uport->map=
base;
>>
>> Then when setting with TIOCSSERIAL ioctl, application can not provid=
e
>> original value for iomem_base, it leads setserial can not work on su=
ch
>> boards.
> Yes - it's a legacy feature that isn't really needed on 64bit systems=
=2E
>
>> I don't know why kernel should expose this value to userspace, and s=
eems
>> no need for userspace application to update an physical address for =
driver.
>> Can we consider drop this member in handle for TIOCSSERIAL ioctl. Pl=
ease
>> see a rough patch in attachment.
> There are old PC and embedded cases from the time before devicetree a=
nd
> ACPI were the default. It's now an API people rely upon.
>
> It would make sense I think to return 0 for the base address if it
> exceeds 32bits, and also to ignore a TIOCSSERIAL that passes 0 as the
> address back. Would that fix your use case ?

If boards relay on this TIOCSSERIAL only working on 32bit, this solutio=
n=20
is workable.


Thanks
Jiang Lu



>
> Alan
>
