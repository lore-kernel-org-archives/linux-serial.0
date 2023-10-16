Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14B4CDB465
	for <linux-serial@archiver.kernel.org>; Mon, 16 Oct 2023 08:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJPIKK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Oct 2023 04:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJPIKJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Oct 2023 04:10:09 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADFFA1
        for <linux-serial@vger.kernel.org>; Mon, 16 Oct 2023 01:10:07 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4054496bde3so42118065e9.1
        for <linux-serial@vger.kernel.org>; Mon, 16 Oct 2023 01:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697443806; x=1698048606; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pAxbAxqSe9AFwPZxn6Qrhxm7ZexkU1w8IaEh0XqaXck=;
        b=iHnxMHMBUCaki0s6MQEDEu2FGum4huWb2tX5U+ILmh3jSHc2dc5SC+k2tet23LtVCJ
         GmA1E5gP7SaGyvp/mXXpvDtUyp04yD7i9j4BN1Q+JSaiMGK+QHssNfURLfhQcaqxsLLm
         LfsCyEhcwfB/VtieK1dmQIp2X3UQ5Q6R7NHqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697443806; x=1698048606;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAxbAxqSe9AFwPZxn6Qrhxm7ZexkU1w8IaEh0XqaXck=;
        b=gi7cx8WzmwavvJCVMF06vGYQr/cBbSmszVF5MW9Ep8gYOJZYmgwcnN1xTEsv//AC7a
         QvHFxlykIb4nyv9ut8IVtKuHlVCOGJSgD2oZe5uzbTFC7iFVGaW1RdP+w5MW4IcEhdEr
         7lrJqH1d7q10mkobKE66+nJcGUcD1TobEHpF3qj0iXJpgFV1ncdnrNgFTUWvRC0wK+oL
         Nrl9m7d2dwkPBogFZwlwea7LvGf4v5dMtfyPBZw0K2cI/+7OTxiMHKcUVs/0sfwwOjD1
         C00ISnnpk+bWrgfJweBkcPjUdXIKlWWO6X+7QpZHWbV+RvZOBWH3bEvKIQmiZxrPvlpO
         yQmg==
X-Gm-Message-State: AOJu0YxcNFMl9qXIcAyYeUBX5KYMGtKH5AnCSheVL+rIozHoZH0zFTYl
        qmDnu5wT+NwxDrGt0/Fy8CM0zQ==
X-Google-Smtp-Source: AGHT+IHizJD4DVfqSoE6FIXh87by/PE6jQ0PeA4U88zE9yzq0HjGDwel1pvnNbBa/V8ls24QvFedhw==
X-Received: by 2002:a05:6000:b46:b0:32d:a977:50b0 with SMTP id dk6-20020a0560000b4600b0032da97750b0mr3849340wrb.41.1697443805638;
        Mon, 16 Oct 2023 01:10:05 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ece6:f4dd:6417:6a0? ([2001:8b0:aba:5f3c:ece6:f4dd:6417:6a0])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b003200c918c81sm7078828wro.112.2023.10.16.01.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 01:10:05 -0700 (PDT)
Message-ID: <0d86deae37877258f46322d4d727903fca12ad21.camel@linuxfoundation.org>
Subject: Re: Kernel 6.5 ttyS1 hang with qemu (was Re: [OE-core] Summary of
 the remaining 6.5 kernel serial issue (and 6.5 summary)
From:   Richard Purdie <richard.purdie@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>,
        Mikko Rapeli <mikko.rapeli@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        openembedded-core <openembedded-core@lists.openembedded.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Randy MacLeod <randy.macleod@windriver.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Date:   Mon, 16 Oct 2023 09:10:04 +0100
In-Reply-To: <20231016072352.GM27774@atomide.com>
References: <178BF2895FF685E6.5378@lists.openembedded.org>
         <a2ad67a0575548b6d5d8d187e597dcd72ae07f64.camel@linuxfoundation.org>
         <ZSPQY6UYg21Z0PnN@nuoska>
         <1520ecb5f4b6959af835a7781b94694913f76912.camel@linuxfoundation.org>
         <178DF50519C11C84.8679@lists.openembedded.org>
         <b208c9c6b72be4ef0f2aadb7bed103280bff60a0.camel@linuxfoundation.org>
         <2023101516-unmolded-otter-e3e0@gregkh>
         <214757eca7f4cd639a7a8d9a822476c1ec30f01c.camel@linuxfoundation.org>
         <20231016063501.GL27774@atomide.com> <ZSzjNgdCH_wmB4u2@nuoska>
         <20231016072352.GM27774@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 2023-10-16 at 10:23 +0300, Tony Lindgren wrote:
> * Mikko Rapeli <mikko.rapeli@linaro.org> [231016 07:16]:
> > Hi,
> >=20
> > On Mon, Oct 16, 2023 at 09:35:01AM +0300, Tony Lindgren wrote:
> > > * Richard Purdie <richard.purdie@linuxfoundation.org> [231015 21:30]:
> > > > On Sun, 2023-10-15 at 17:31 +0200, Greg Kroah-Hartman wrote:
> > > > > Can you try the patch below?  I just sent it to Linus and it's fr=
om Tony
> > > > > to resolve some other pm issues with the serial port code.
> > > >=20
> > > > Thanks for the pointer to this. I've put it through some testing an=
d
> > > > had one failure so far so I suspect this isn't enough unfortunately=
.
> > > >=20
> > > > FWIW I was looping the testing on the complete removal of the
> > > > conditions and didn't see any failures with that.
> > >=20
> > > Care to clarify what's the failing test now?

Failure is where the data never all makes it through ttyS1 and the
login prompt doesn't appear. In our CI this appears like this

https://autobuilder.yoctoproject.org/typhoon/#/builders/145/builds/711/step=
s/12/logs/stdio

Click the magnify glass to make searchable, then search for "Target
didn't reach login banner in 1000 seconds". You'll then see the echo
helloB to /dev/ttyS1, then the "Extra log data read:" containing the
getty for ttyS1 which woke up.

> > >=20
> > > Is the issue still the second port not always coming up after boot or
> > > something else?
> >=20
> > Yes, data from the ttyS1 getty is not coming through from kernel and qe=
mu to
> > the test framework looking for login prompt after qemu machine boot.
> > Workarounds like sending "\n\n" from the test framework through qemu to=
 ttyS1
> > or "echo helloB > /dev/ttyS1" via working ttyS0 don't seem to help and =
wake
> > it up.
>=20
> OK so for trying to reproduce this with qemu, is this with the default ua=
rts
> or with some -device pci-serial-2x type options?

The port sometimes doesn't come up properly at boot.

To be clear, the "\n\n" from the qemu side into the port doesn't seem
to help. The "echo helloB > /dev/ttyS1" inside the image does seem to
wake it up.=20

The qemu command we're using is:

qemu-system-x86_64=C2=A0-device virtio-net-pci,netdev=3Dnet0,mac=3D52:54:00=
:12:34:02=C2=A0
    -serial tcp:127.0.0.1:50421=20
    -serial tcp:127.0.0.1:46457 =20
    -netdev tap,id=3Dnet0,ifname=3Dtap0,script=3Dno,downscript=3Dno=C2=A0
    -object rng-random,filename=3D/dev/urandom,id=3Drng0 -device virtio-rng=
-pci,rng=3Drng0=C2=A0
    -drive file=3D./core-image-minimal-qemux86-64.rootfs.ext4.19673,if=3Dvi=
rtio,format=3Draw -usb -device usb-tablet -usb -device usb-kbd  =C2=A0
    -cpu IvyBridge -machine q35,i8042=3Doff -smp 4 -enable-kvm -m 256=C2=A0
    -pidfile /media/build/poky/aa/pidfile_19670  -S -qmp unix:./.rbmorp7r,s=
erver,wait -qmp unix:./.kf6y7yqg,server,nowait -nographic =C2=A0
    -kernel /media/build/poky/build/tmp/deploy/images/qemux86-64/bzImage=C2=
=A0
    -append 'root=3D/dev/vda rw  ip=3D192.168.7.2::192.168.7.1:255.255.255.=
0::eth0:off:8.8.8.8 net.ifnames=3D0 console=3DttyS0 console=3DttyS1 oprofil=
e.timer=3D1 tsc=3Dreliable no_timer_check rcupdate.rcu_expedited=3D1 swiotl=
b=3D0  printk.time=3D1'

This is with qemu 8.1.0. The image we're testing with usually doesn't
have an ssh server so we're using the serial ports for control/testing
and not the networking even if we configure it.=C2=A0

We use the serial ports over the tcp connections to handle the multiple
ports and have python code for that. I did extract that code into a
more standalone form, https://www.rpsys.net/wp/rp/simpleqemu.tgz where
"./commands.py" will then run a boot and wait for the login prompt.
You'd need to set a path in commands.py to point at an images directory
Extra log data read:of an qemux86-64 core-image-minimal OE image build.
Setting runqemuparams =3D 'nographic' gets rid of the graphics need.

If you don't have a build, I shared a prebuilt image and hacked config
which you could point it at:
https://www.rpsys.net/wp/rp/simpleqemu-images.tgz

I did have to remove some of the cpu qemu options to make it work with
the older qemu versions often found on distros which don't support them
(the q35 machine). It will dump log files into the current directory
and there will be a log for each serial port.

I hacked the script to append sys.argv[1] to the log filename, then
experimented with a command like:

for i in `seq 1 88`; do ./commands.py $i & done

which launches 88 qemus in parallel. Sometimes you see them "hang"
through the size of the ".2" logfile:

$ ls *.2 -la | cut -d ' ' -f 5 | sort | uniq -c
      1 134
      1 249
      1 251
      2 254
      1 255
     51 273

273 is the correct size, the smaller ones are truncated.=C2=A0

Sadly in some cases this test appears to work when the issue is still
present with the issue only showing up intermittently in our CI. It
does seem timing dependent.

Let me know if can provide any other info.

Cheers,

Richard

