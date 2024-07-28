Received: from sonic310-14.consmr.mail.bf2.yahoo.com (sonic310-14.consmr.mail.bf2.yahoo.com [74.6.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3A338DF9
	for <linux-serial@vger.kernel.org>; Sun, 28 Jul 2024 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722189416; cv=none; b=RCLcOS885tuljPDnfJz4n9/VWhHKpq44uh6mYrsxBW4M1FIaSh2QFCt5FXbDAnUDdSf7X7FyIjTVPXf4c7Bo11/EE2tUu9pwks/dczs2ekGfvEvFlV+DfaI0OYRZ9YPUaixmbouvpUiT4/B+uYhy6tEZvuAQihps+RKuB1DouHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722189416; c=relaxed/simple;
	bh=Du8Y9uBFN2tQMITWqJ91SXQ4qbHuflV6EP952aYsQkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJ18kXHVaFfJkToOLZD9iwTRT70dIKwwkyxyGrbcikaC9QIgHBiIzZDxljVAjpWCamoUjgUyQr5h5JbtREv4djjZ4+xSkL1rWyL4XjlHPPwsD/Xkf+VNjCQDoJnjwboUh3+PglEACpfuQbUN8svwS8cITOk/Btl5PTurI5MSAsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=mZ2tl6cI; arc=none smtp.client-ip=74.6.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="mZ2tl6cI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1722189408; bh=gpS1CAjF2E4BxdNrrAF/J2gaU07mwhcUgr8cl9LhRqU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=mZ2tl6cIIhLUTSkO5OpoRBmzCxxvwBsw6kQBcMu5+kvb63DwvASuAWGNxd16V1hB0soNQipIoR66K7bDDgmndg9/ewOrgZ8oZBAS9buAQdm9d/K7iSLqH8uNXWaG//LIJpi9ngYA0YNFJogR1mMT0hobPryG+N1ayLr4YOVhkSzQA6tkKl7Y2foUcmXKBCp9sN68zkEo8lkQS4gNsTsQNTW6L4tGQC8b2so4dQ1AXjZmw7Q3SUl/y3XiFDWm3udPZz2im0rnX6N12zUATdqPsOG++7he1FeicU6S61CBLhRLZ8NrJwdgJ1uk0tOVEb6zGM0OFCPs8kBs0zYpQdmViw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1722189408; bh=OiFV++KQs7Y7s1ITwj6AGrZp4j3hUF+f+zAaN7i7FIy=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=BvxHUUF7sWUA5OBu5t2gSRuEuHlNtZW9xQOCKrs4ORAzh+yllVKYeuL18wXncZXj7OPElKQrWsw/k3a6FQI36nUeU5BPKzlYc/A1JijySBWXFaYqcXSwql9Nz+C0iovePFWAFJ7H55i3DzruS3vXIk0Q4tOGUZgxthk8fFX/EASuZXKQNtaDVUbwvVVAPTMA1+9vKm6mpJH6IoycA1lPb2jUPPT/cCGGnx0iE7u5zEpqL/Xi6UEYgWsjIG4I6aneX2F7wFpk6KPEW2atGIz8uJNe3EdMD621rLaw17/1mCvkrwAJprZQ/fSB2cEiJBGHmNiE0vtBqoJgucT9Wfu54g==
X-YMail-OSG: mHWGCJoVM1nkZXocxjVy9omjFtFVVqYPnfP7N89sVNXjdIXtn8m7jW5NPnI.HvU
 OZkWBcQMnDw.hE5F0xvNpT53dI0e7H_3KM.QVWUEtLGNTapBhB.1X3M8SIspriUxDRwFmM_0grOZ
 mcg2I35imGpW416CXDAQ8nFatyXAE0rrzag0WEpOfPham3djlDX57qHlPpP7JHqTA9um7wose3k4
 P7HZnpujMxNrzs3Fizq8MrrRTuK5sFiUxGsBhfmBkykPxbEL14rmXf_JxXhZ1N_U3kHSWdQJprqE
 DVC8DcorNRGrOlIDlZP_119T_stZeGERevgRRfTJ8okEeoMuyb3sf7k6yJ9tdma8XOu7yz8.Tt10
 TVZixkCKtC5UoGnygzINcev4qiwY31ewglmVNp0JzOPDdOTaEwJMQgVQOJeh9UfOCPIzX3s8Oedk
 2qfTRBNFXhg8fiEkZ1ObW7hARRDhVkvcyuFooafYPA3xTdNYPY969YwskCKSvGliO_4GG1lPvwDa
 3d1oSJ2FoGtoMbdN7s20Fd8QqhWoTCjQsOz6crwv5BaMis8tgu2AzhAKf10HAO7WjDyWzKh.QZK9
 duNUc23KS26hlABSXw5mwYyNGxssaMLJ64G_4SCyQmhMXxq_qyzwwlfiZbC5lnkVlbkmVjUOazcq
 rqQAcnvKyWDSIcgGNVLicBE93yiLYqVzCCM7I71CfD1mMs8gCQP6U8rGI_jfmbG4mS4mzya2Q9FU
 tt9lPgadEl97s8tEcVA4wSrcDhRwUIGfNmXkx3nSk_zbeDfSydbzM4mBBfQqDfzi5lQOp_RnTGpR
 tkbpGD8oLBdjsBkCdiuyWe0S6T2wssmPkfyWx7xtIq.DZRqsZ.kGzaI0UgGJLVzx8KFDCQhCpeAM
 gI9MLbw0e7S1naO6dDrDEJqz5dYtTlvxEN.ZYGu7gMAYKvxfceQ1RQvvCZdyzWyhfmLxgymHcemz
 O80zlFLb8Dczy6Og2mwqCKmZsAKlnOtDA7coOuqvoojzwkBFE.JtT8sPqJDa48wj7JSnQ9J4gCPf
 kPINIjyNDa_fNqsNiOaQqPriY5qMThxGPmjH_BDJ5YaXLceo74dwlWXZthmmx3tnphxFNFJvHbNu
 1L68hj57yIteRl7xJbHO1y26wPg8ikgK8xqRLY.cMgKkfrIrjhgaGSF5Dv_iw7b9v0z1UT6YXxQl
 MC1cH5mR.gxLRYg.o9KM7wGjFPmy.c6cCe0jviXQq7d2u0Wsv73A6E_paP9gWZQGjCxwv9zwLOCO
 pgUNhxfW598.mb9PeTohQEFfRD3D5aOgHKWRWppTQ1YhRZtimZ.C3LEv7VsZQBYyCt4GFToFYI2Y
 F09SZ4JKP.OgA.YAzks9ywpORikL95_BQ.YDRM7KZ8Ru8ymNhufRrU2Y96tpPpaRwv8u1jMMtyHu
 JpJcBLLC53GibcD8.FPG_vYfGE.3M89sqf3piHGIBOv20M9hiJCawptCgA3HpD08cScPUuBovrhl
 6JPWqXG2CWdRvMGf8o0vam1EDkditnkrUhPPQJiBk_vxDURPPhjqzRjqvA0Kzsz_ix9eyFAd6Q8M
 trkUk3u3thTTlISZnLUS2aH2M6cHfcD_cU6GtS4dqJ5qkC.Xsw8HGv4DxZPPf4rIT._kNVR_Nfxy
 oyA92anPQo0QeBSEmViUYPfEEPOZjsTAHZRcKEHBH_8h2NQTteccYpFDHXbfYyzLx34ZHiF3EzPc
 wxj8abTJhJOVNH0S.qL_bzjq_aG6NeyqWgMO.CfM_vIHSMgO5DbiGsHr4844XhoBYUuSnw8lK548
 Sa7FSlTQQMd70MaNDRSRoRO_rf87LxEGVJ38ujxoLCPBwhXkrkg3XIGzxemk_HKeYLn5Xkk7eCFS
 hkKzkBO0BLRM6b5BdTEiA6DrmNJSAYdBIL2wXrO9C52QkEZSJcKKV6ioMxFZois4tVDgSakWAT7Z
 SaSvQK8hwfdUIOCqdlvenvRAC1zwFLBlUN8jxKeDPFQq2m.qk3QNdK.j7PLKQwJdwavyekKQIbgy
 Q7nfysHdM4VkWDx80aqGjmxD2mpjKIsAUaBAU0mUtW2dkL7SE_MEsBx9W0O.D6aRU1UK.p4iwmvs
 ZFoGb2lPEgRjwbUxq22EmnX0C1wWT9ZYRm8Y6BcX3zyrET964TcCAHYh_Q2ypZXOQNPn2AML80Q7
 SWSDx6TwIYrwAHnZkKrsArU9Llfq9983AP.sHweDcx.LRBTGVP9V7.LBOhNPmkyayWk_79MJdEUY
 jXxcdXKysy3mZp13kPx5mJcbvmGneknrOy2LUZnLus7GgrTPgjsI-
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 5f97efd9-8a37-4423-8a3f-53f03f8484a7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Sun, 28 Jul 2024 17:56:48 +0000
Received: by hermes--production-bf1-7bd4f49c5c-lhqxz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4f618d9c1cfa518165b2e17e4ffeaa47;
          Sun, 28 Jul 2024 17:56:44 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: When /dev/console is a disconnected /dev/ttyS0,
 TCGETS on /dev/console results in EIO (Even if TIOCCONS is called on a PTY)
Date: Sun, 28 Jul 2024 13:56:43 -0400
Message-ID: <1831764.TLkxdtWsSY@nerdopolis2>
In-Reply-To: <2169369.OBFZWjSADL@nerdopolis2>
References: <8411114.T7Z3S40VBb.ref@nerdopolis2> <114770592.nniJfEyVGO@nerdopolis2>
 <2169369.OBFZWjSADL@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Wednesday, July 24, 2024 11:17:54 PM EDT nerdopolis wrote:
> On Thursday, July 18, 2024 7:52:15 AM EDT nerdopolis wrote:
> > On Friday, July 12, 2024 8:59:58 AM EDT Greg KH wrote:
> > > On Fri, Jul 12, 2024 at 08:52:15AM -0400, nerdopolis wrote:
> > > > Hi
> > > > 
> > > > Background:--------------------------------------------------------------------
> > > > This issue becomes evident on VT-less kernels. As when there is no /dev/tty0
> > > > device, the console defaults to being /dev/ttyS0 instead. Although this can
> > > > also be replicated if booting a standard kernel with 'console=ttyS0' and ensure
> > > > nothing is plugged into /dev/ttyS0.
> > > > 
> > > > This issue prevents systemd from logging to the console.
> > > > systemd when logging to /dev/console, long story short it calls isatty() on
> > > > /dev/console, and when /dev/console is actually /dev/ttyS0, and nothing is
> > > > connected to /dev/ttyS0, isatty() fails on /dev/console due to an input/output
> > > > error, causing systemd to not log the console output, because it rejects
> > > > /dev/console as not being a terminal.
> > > > 
> > > > 
> > > > This is noticed on a VT-less system with Plymouth. Plymouth calls the TIOCCONS
> > > > ioctl on a pty device it requests, to redirect console output, and in newer
> > > > versions, it displays the console logs on its own without the assistance of a
> > > > VT.
> > > > 
> > > > This part of it works, Plymouth is able to 'see' what gets written to
> > > > /dev/console, log output from processes that write to /dev/console directly
> > > > (for example 'echo hi > /dev/console") do appear in plymouth's
> > > > /var/log/boot.log, it is just that systemd is not writing to /dev/console
> > > > because isatty() fails to report /dev/console as a tty device.
> > > > 
> > > > The alternate fix in for systemds https://github.com/systemd/systemd/pull/33690[1]
> > > > is believed to be that when TIOCCONS is called on a PTY, or another terminal
> > > > device, that trying to call TCGETS on /dev/console should no longer result
> > > > in an error.
> > > > 
> > > > 
> > > > Replicating the issue:---------------------------------------------------------
> > > > 
> > > > This program replicates it:
> > > > -------------------------------------------------------------------------------
> > > > #include <stdio.h>
> > > > #include <fcntl.h>
> > > > #include <unistd.h>
> > > > #include <errno.h>
> > > > #include <string.h>
> > > > 
> > > > int main(void)
> > > > {
> > > >         int fd;
> > > > 
> > > >         if (getuid() != 0) {
> > > >                 printf("Must be root\n");
> > > >                 return 1;
> > > >         }
> > > > 
> > > >         fd = open ("/dev/console", O_RDONLY);
> > > >         if (!isatty(fd)) {
> > > >                 printf("err on /dev/console: %s\n", strerror(errno));
> > > >         }
> > > >         return 0;
> > > > }
> > > > -------------------------------------------------------------------------------
> > > > 
> > > > When the kernel console is /dev/ttyS0 and /dev/ttySO has no device connected,
> > > > it prints "err on /dev/console: Input/output error"
> > > > 
> > > > When I strace it, the relevant line is:
> > > > ioctl(3</dev/console<char 5:1>>, TCGETS, 0x7f...) = -1 EIO (Input/output error)
> > > 
> > > Do you have a proposed kernel change for this that solves this for your
> > > tests here?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > 
> > Hi
> > 
> > Sorry if this is a duplicate, I accidentally had rich text sending turned on,
> > and did not realize until too late. Anyway, to answer the question, unfortunately
> > I have been unable to come up with a fix on my own 
> > 
> Would the fix be to make /sys/class/tty/console/active report the terminal
> that TIOCCONS was called against? I am probably wrong there.
> > Thanks
> > 
> 
> 
Hi.

So I was doing some grepping, and throwing in printk's in places, and then I
realized  that the ttynull driver. Turning it on, as it was disabled by default
in the base config I was using from Debian, and then booting with
console=ttynull causes /dev/console to work when systemd logs to it, and then
Plymouth when it calls TIOCCONS on its pty, the log messages makes it to the
pty. (The proper systemd status messages are now working again on VT-less
systems without the need for /dev/ttyS0 to be active)

So I think I found the solution. 

I think the only thing I have to ask from here is if there is a way to enable
the ttynull driver by default with a config option, so I don't have to boot
with console=ttynull in all my command lines

Thanks

Thanks



