Received: from sonic308-2.consmr.mail.bf2.yahoo.com (sonic308-2.consmr.mail.bf2.yahoo.com [74.6.130.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B002318046
	for <linux-serial@vger.kernel.org>; Sun,  4 Aug 2024 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722811554; cv=none; b=MK6SAK6c3/x+GRP+Gt7/ZuBSfIf+9IlVHr3gNDyyl8hB6KosARQdtAUKQt5TKDT85EPH7Ij2oCgkVovxBRTeiVpjKGjYwsxawQ9kn8tZWbix4QtWjLejqNb4H1uiouHNYYkQdXfbUga10OogkQNKpbUIGOyRlmFaGB9c5h38jgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722811554; c=relaxed/simple;
	bh=YwMGglGFVhnxIo6XhPzI+89WXzaUidW0fE4qiEmMTiY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=MaOyrorfRtyV25spwRrToCQd9f8qx61x4S96E+Qdu3xADF9OIZA1yeysvAdlZaf0ySRKAPkfSwL8+KE78W8Varp8TjinX6BKxrhtTJo2NVjrwhVfmiOFPGstMYVhRzW1doc7953/u4QkrNvJX36bfk7JOtuC1qI9L5+YLR4tj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=CJ47tYRC; arc=none smtp.client-ip=74.6.130.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="CJ47tYRC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1722811551; bh=utlCvYJ/orFptSVZeC1987n886kjjCLOKO6JbcfE/q8=; h=From:To:Subject:Date:References:From:Subject:Reply-To; b=CJ47tYRCeCGCOHkgqYK2b1tj/aaivGhDoVskW3zRVBo8V4qf/Ry9adOLfheh4ceUypG1qrD/y4ecv9eODZCmGMBTl+nosgRZHeXMKMRZeEgz5433sQZRu6OZpYTXD2m25ShhQbOAhEcx9aoMgHi5W/n37ai8PEy1nYS1ZLDy2Z2kz6eiZ52avV8WwoWbAkAz35dc7y+iFb1rZHis4TrKO6OddgnCxP5LAOzc+H+AGSYcFJecKnbt9tvh3pU0q4MH2pqf4j2hGLFSei+zpi5/cpG2Y/7ouVUGO3JUz5ToAFCMZ/VTreWzJU+VXAWzObU1uQkQPPhpmdb9wsuUpi6UFg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1722811551; bh=wMXLdvhfOh3+KQU28PqT1nqqUzZxcnUOTxiDSWeKYkp=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XiQ49FHtBW8071mJiJ1tsnBp3nWBMcw+LYpuH2jVu3xYfRgl5DJHRaJO16Kf/goOFLJEEqT0kNUDj+ZrccRFgo0hIoSVEKhlKAqbEOOKpufMoehpyvFHScIj+NEi9K6BoUoI/sN8Mh2TalUt5gSptHvQfVkcVAMZ93fD8SDYLTro+caajdo26YBd9uyup1WzUiIRlfa5+VFe99eIVD+dPtRJZrJxhF6880oYKFxBN8CDcypjG3naTzCIAEnb0YIeLeiygfoPe2qK+6R+Iok7elyWo5oaRMkuu5js6NisYsbUlv3sB3CyeU0c/gKPbkLh8D/Tig1MH9Jp1unue9GKWQ==
X-YMail-OSG: j2xArJYVM1nqP.u2gBLsB.DIGGBiVBP00qKuNeifS7JzoNHca3APzynmwniX.Z6
 W0VcHJ6ujDZSgOkN.TD21OFJr3dbv_0wspH1jeQhKzeMRbhQFSGNrYJci9lHn2eG0JIYNCjIiJYc
 flkL1wpmKIT45nUU6XAXsa5sJI3jks7ZyBtmypfXyQ1K7zI8HOM17VqRUefrx6NzXYayStif5rGR
 ezOrZvtUPhoLUSA3tEVVuaI2RO4.XAL_6wNwu4piQvKYwpToFYddh0.0HEzfCMmVPf9VCLTWYczr
 ..BkhEDnSO9ASa6EKvIhrqmwQiS8_U3BHj_LTD9ai413fCxBhZ72DRyAIrOiIXNRSDGYRaBDH.xf
 o_kF8YQaf0Z_c07tIT2K75tkCAJdyUa0qfMFPIrYpkhGO_0J5dc.VmFfaNef_DC2YOwdt2t7rHkF
 ALpVRjXC1lLj3HBuFqtsQSqGd3NWw4xbm2LqDFbMKB0ObIK...cB4pzD.ngSHFSbKcoc0jxCd_yY
 sRIpnr5CY3sqQ74zCkBmC7Yjsl9QayrmpLXg5lIeU8.f2z5oDx31UrgQu8nMO67auVgcNWQPeqOx
 imzaGJ9bO9bYmDsnVbQRrOn5fXYCFcM1uPogwzDhKQof8En1DOe7h0EILZT_UPEO6IoH9L9B.mrP
 _d_KPV2t_7ynNOEnA7Q20Y1nEkzTXDCrpl1Qw2TsA.sSnTJOqNw8fKm8XY1Yiv8dkAxQv5m0khhh
 C1rBMuJXh_g2hYTjMCrZibZWQ_9ww4UBSkRqsx9zwzvI97QnnmdjEnS3UIEmjxvM9n57tr4GjNpk
 RauUlt75BITW9m1PVj6QxcNeJCEflFNbjUuhyonJ4XNC4ws.QXnUG9eLR1C2wuvb_48Plgg1nPsc
 GXMWe_63Ac73WlDko8p9Wb6tqiQ0IVaiWulOkWRzeF0lIyEP_xbHNer1vGjZqWhKSC_UheakxT6Q
 PWWlfnc7XL7w6zoklnJsXpLimI6yVugpGc7MuymOo76WHFevWYlsEv.Oi2YJ32p0zSwq6w3y5wnv
 1laDdCHMaD5C.vMaXEcm1GukJ.FDvIAtUAzpi8gC4h_x3NRfRuL4HZcTnaw76SCB_TDQ3F3gyEiG
 DOpwShCjVMR9FF9Ig6Qys0zv4puBrgIjyTdX2EaNOxkJz96Q3lTG1ddiA.giiQ_M_hmK0g9RAHjv
 GMr3Dymf2U8q6K_RHCl6MphJEO5CxPrNgFo8p5R9ptr.cB8XwNfQeWF.lvEccvfKyXAcloAtvenV
 b4d4eZ7CwhMlP8KqwhMfJZt4iPTKuIP5HsGIe5G.hDYPp4knyQK8S81a6bibq93B5nhKnvlKSCTN
 Tp6uA1Inv8LENCtsgnhlrYHYMwPwQSeEH_DyWsfLzjc7TXkJBvNvEOZrirtVPJO9PQVLs57BPLeP
 nB_Dr8jp1JP2sD8RNTC6QrQ_g7uKN8wMrsEiSWJPdJaJ3ycD8DJX1WJeL0dt7pIvKmfdngvRY1mT
 B.eCOC6lqExIFSqZsnyLOIFrdTCvxJXBv.4Lzw848b1LGTZXh41tUAhRovQW9bMbizzptOt09kYA
 7aRTWZSstyJTAV4VwaA2tbzKlqbS1wr1RQT8z61X03_lJPtm5AnG_9dW6FpyOZMuwEkzQukpjs1g
 dwjAJfadP5OG9HyaQS3B9lTu0v5gvZpEqMyU3BA2QiBD5FV1GxGrxImVmuu3Wcb53TXmefS.GdlL
 oo0DhgKYVQm7AoBUwE2vV4aINZyzXSdWkXMnLPOeCCOdI.fl.j0SwrlQG.dN953Gq9a_mb35Ynk6
 u_wHucimEFokYCdWho4b7VMI9qV8i5JmyNsDiJDqcPi4yYwBzDX4wUOcbk2HJLwYSi2vajLgHA7e
 NtROJKR4JoCGZi4mpIdxaYbuSQ9_0JFZbkBC3MfzucGYwsOFIQF4YL.0L2ggocCSNnhyLv.tQjiD
 A2843QybzRP86qpCLMIKiQgViI3Mt37iZ90zJajKG3gENPa7EO0XWjpS54OWZfSwJUZ18tLZpLJg
 rsm1XUF_OzvJamM6rVFuEfUJ_BCDz.9w6Pvx7qHe1tSuvpkni3fXMwQvOXc_Er9aSg9efjAdWcXE
 xKM3Phk1y6kQy8vYfBkiGopIEUkjlGByoK6Ft7y0itE433_yqpETT9ds2wfludWn_21SEPid_FXJ
 a.5Mf.xCRi0SFYYAxCas.3PT9rwX9nT3t9zoE1w1qfyvCap7NxC6Dn2E3ziIklyE1PXQxOEcPf8t
 cPW7UlRp4KCvOekT2Rnee_Lpos7RKu_aFzXqa2Oe43.g_kzBx
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: adba5347-824c-4415-9c49-80e4efa4778a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Sun, 4 Aug 2024 22:45:51 +0000
Received: by hermes--production-bf1-774ddfff8-dhfgz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1b55274841cb1f8d3d395b8ca3d3322b;
          Sun, 04 Aug 2024 21:45:07 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org
Subject: /dev/ttynull and VT-less kernels on Desktop
Date: Sun, 04 Aug 2024 17:45:07 -0400
Message-ID: <2708910.X9hSmTKtgW@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
References: <2708910.X9hSmTKtgW.ref@nerdopolis2>
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

Hi

I have been doing some testing on VT-less desktops. I brought up an issue with
how systemd was not logging to /dev/console because isatty() was failing (in a
thread last month which I kind of bungled by accidentally sending the first
message with rich text enabled by accident) I solved that issue though. As
disabling the VT console causes the default console to /dev/ttyS0 and the 
isatty() calls on it were returning false.

I have found out that this issue actually already has an existing solution in
the ttynull driver. After enabling it, and then adding console=ttynull to the
kernel command line, this allows isatty() to succeed on VT-less systems, and
now systemd is able to correctly log its status messages to the kernel console
on VT-less systems, without needing anything connected to /dev/ttyS0

However I have two questions:

1. Is there a build option to make it prioritize /dev/ttynull over /dev/ttyS0 ?

   It would probably be neeed so that distributions don't have to worry about
   the logistics of adding that to everyone's GRUB_CMDLINE_LINUX_DEFAULT come
   the eventual day the decide to go VT-less during its upgrade process.

2. Is there a good way for the userspace to know that /dev/ttynull is primary?

   "ttynull" doesn't seem to appear in /sys/devices/virtual/tty/console/active
   when it is active. Which seems like it could make sense, (as in a check if
   it is empty) however if I boot with "console=ttyS0 console=ttynull", "ttyS0"
   appears in the file, but if I boot with say "console=tty0 console=ttyS0",
   they both appear in the file. It would be nice if in the first case it would
   report "ttyS0 ttynull".

   With Plymouth, when the primary console is /dev/ttyS0 instead of /dev/tty0
   it defaults to serial logging instead of showing a graphical splash, so now
   if you want a graphical splash on a VT-less system, you have to also specify
   "plymouth.graphical" on the kernel command line. If it could see "ttynull"
   in the end of the file, distributions that go VT-less can also just enable
   "ttynull" as the default console, and Plymouth could use that to
   differentiate between VT-less desktop systems, or systems that actually want
   serial logging, so they don't have to change GRUB_CMDLINE_LINUX_DEFAULT.

Thanks



