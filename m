Received: from sonic307-2.consmr.mail.bf2.yahoo.com (sonic307-2.consmr.mail.bf2.yahoo.com [74.6.134.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008E822F19
	for <linux-serial@vger.kernel.org>; Sat, 10 Aug 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723302619; cv=none; b=RLqOP3wJvvwer7J2xLYfwFYy2clPSJMyxgzH2ozClXD7SHbMunLC33vK4zMI7QUs18jUqX7JvhOxdO3sSti0QoQtwWH6FvqQBVXNhblrtnLU5kqH0qWpi8DQ8uNDiYqvWVDdO7oAtWgB6ktFtariC99CmtLyBa21r57Mzuh65ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723302619; c=relaxed/simple;
	bh=0mFZYSTIDh6X5bQD7P+1yN6zRdXzlqlxG0DnelHtrSI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=btneO1/PSIs252pjjDf3iC398RqdbJJlSFbv9LUAk2rEyJcbBqlJiBTZuJZFkv5SuiAlv07uawYB4lC17pOp5FqMNqRd2YuTLWeSb7E5clpcrKVh4G6ulLzBtNSHVAbtD7miGopkZB6fzDWOgQAaSdukDwKt7pCUIWLPKxKBMYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=E1YQnAkq; arc=none smtp.client-ip=74.6.134.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="E1YQnAkq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1723302611; bh=BMcvLyT9UjCfFyTojBqx0/Bh/dGTOi0HwNi7C48Nocg=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=E1YQnAkqQpPqeabKdqb13+VkPf/tTWSjQcht+Ez8FBNJjsT6u8xHvxwYC3DFmU2vrjRVRNccUuTxw0iW+y+eoLn8zgCPhCUxg9x/2oBu+PX4tK93l9abE7tKatSfaV7LuUTF6ewif+cE96HsDPyAowC4C2w7b+7Zv0sP2HEz31SUy2ywYUQEwojSL6E5MmzbMR6Bg0vLjOFyZWcpznmqCoTGJEPrd/LrJ+J9TW5MFt0oVO0FHQjgD/DuXnEw2jBTyKNWq3CLOyC2KV4KcviaDJ5MKvAMGKiQ08LD82NE1Jelgv6kHHOm+bXzwhzVekJulXAG1U+1Gniosd3TjhoUGw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723302611; bh=jjsgqE/jdM67kSQMMf3QE7Yl3Tn6fwVT9UEFc4wNPWx=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tept5ezwCVZFrwQIvO/8IZI/v/mxSkc/9sSWU2H+5DpnuB70gVdlBasXaV29wuha/sq/2sY3KqmKJYPyCyO66pligmAijZZuc3/m8n8myTeiCFL98i5aePjPTQeVATJkOl2jInqMKbQ+QgsN3dCkYK4Wgoo/yQmmbwdZwPMzhdndRzVp5dLOsGXTFKGBEDDzFAbUVvrh91SyWyJEFjL8Qinw3V0bWQVyq6t3ULzpY6ge6HaneLKoYzB9MIlNsr0DiMKKLASspOXArnm4xuhHUh/ZCiORFXWOIY0cvRd3i3Y4MUYvSnu2t21+ABEqmtFwwgLJS/XxIuVMSrbtHKNDlA==
X-YMail-OSG: vpqart8VM1kkLJljRhB4dF0WJc3EzlWlOXsnb8EtVZn0_4zla2ckEYCJYEXt76u
 kDZILdZaWVH3sVuWZsTSvtz4vaz25CIdOAJIkKtswjqWBOJT8m4My_E7MhBzZShqADr3A6R1lYUF
 sqrUqPvz9ofWukiHlPJvPKlg31BplQ_JwsKpCSquVP5tiXc9eoMr7pFuhNei7ICAGX0.3SLsRu2W
 p188RlsamiNHPNFlwkCF45VlWnsLzkLK2YuKrzRLAJk_qV4u_rI4V8i2GhFbwqPwSBvQsUW3IO81
 WTQ7dxQtuCrJy2ZmaN4xHghEQKYJrX6B_JhRF8LOIVrrNBc8rrCiXuPabucwV9J8XXqU.4Uowv8a
 jDt98sKjNyix9DawcdG_gNVziEti55rFizeYn6ctmLh5n6L2JHRudHX_DMeYNxUJGFxA9Y.YmyqU
 f1N13dkPrnyhuOMKDJhTYfgx3R.5mj7nf.X82M0B3fDVifPeEIGGnpPu.HTHlegsWUIV_z97pDmW
 96vm0kWkTe.9oZgsv3oGPdf3p.JCCSF7KZhsAXFX3iyw8POz0_LKrQ7twUHTFZcP9gx2zK0_6q5S
 RESlIdDYlMeiTVxzX4nJgRvdkT1NbW7GLnOe1UubxRfot6FU52qIJgGsi.RiKgQeGfNJM238n74O
 vDnLLK0RsdT7s2IEID9qe7xvRVepRwYL2An_70TPL9lygJA.3UP5yY2iK4ekzGSD1aDNMwDxcppk
 DHoNzy8765TuRDav34VhmYdvgzBW6gNxPr6yEYYxrmPt5U5swc6h2v_ek8WA2dFMJhG9_T1Fnw1J
 2HHEz.prO6wMMX0wu6DIg8haKDRfVIawtoysSzcu8pPvzbQpBBFl3HI3SnasvmsA84aWYYp9Jkkz
 AHgn7IrwjmoPlNCh1QqsBzZr76AfYliu.0I.JUGzaM.9Yhz_9Kb27N2.hTpdyRYmBvf.2wU9lLom
 YBCnXgQAKzEdpNRnIDOac0lWChDDRxOo0m2zSh0M_rM0eJsLVptcozkSV5uf9gZJoDAjGRKuxFuD
 d8H1HgDkhYxxHCCCB8YE4Vc6M3lddGiycr25_szLR675cXN7scGJsIRa5DkjXNYONQZfoV5niJPX
 bm34zVsCYSdJ.J6nPd3SNMID8SogMukAi.NA8ueTLvbauOj46BeKd0DDAEanx.o4owI_CHtNK5Nz
 AdiXj4A5DfBILTIjPFCbJLcpHPgEM1A2Xwebh.gbMnUcZd.ybxWNJpijcQI1ixf5RJn5FyZKDTSG
 V5If5ew9_Wu_PSx5eZhDdpF0gBALxSwy4dQMe02aLNAt8nOiq050RFuIrdFdWt1PiYt6X7ka6bC8
 NZCbG05XwXKgNXqxTeEOmSmZpBhReqN0POnKopZaJkVSZU07Fn8SfjCOVhdROBM0etmTbwdF_PyN
 XaXK8Ut4V.Jkua_FmyI.lDNa2.fw7VzDuXh6ltgv8v3KUTVlmR9A4o2H16bF6wQlTyqEq0yQyZ4S
 TLBkwNCamaS2WSrLIPKa0YOgnCZEnlloKUCC2bVTwM6es3MkdrkwlTOZZ17NiwgcBQNyxEI7Tkjn
 7V9uicv0hLuWNNAqKo.CvidkZV6CrBND2viRaXo5XBhGwA_QkbwkEHFThmiBcFkniC1ITxOE4IZ0
 w97qFSfXEKaRhNqQK5k4zA1jb0luq7RkfBg7aDzgescAuJYcgw2.mtmVsxRw4qe.48BTlba8IuNS
 b3O0tBgShfwJrzqnFTxw0SAIIX5q.TVbSClQhCcIh0K5pdik6uipcrAwOUDwKkwr95WQXyGRwqEF
 KZ573CXGGV_Y7coRkVaQytdjgDipJUliKNQzsYaiE8RNM9k5UCiHnEfJ0Q6z8GKrwedTe22h8neG
 YQqAuyvxjIr48NVnIl125L1_35KXXT4uO7GIywIG4tI20h4pqBe1KpuRJ0xqqnCxykQ__kR.v.S4
 U7WB7zUyxg5yukL5lpWaCGiwHtQ1ezQkVKIIaUAfMiKToKmGR85yIrOEAs3NhkrDf8.IETIFedaH
 k7BbNwOJYTXpkhtm2xyktyePLn0eYDOG0FLqZ5QcKfyMnN9eABckpt1IYCh63woi66GtMcK8ALJG
 2lET0QJCiknTEpDZFwggz19gMVU0OPY8YUQCzGsZZl5AmCfYhTM6SJP8XcpPUr5SLWy5sQJROJia
 Uf6_.Y7aypcWZBMdRqPdEKOpo.ErAv0EuqySL7fhOCL7kcqv5aBzm7jtj7S19lm69ZO8CN7u4rGN
 qyrGFIjT071FmbFORhEG7jekp3ZrvTPvqWtdWLaJS4DxqFtyYwS3hq.SdzbhCkstDTEY-
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 53b13859-f80c-4e19-ab68-72fe47c2b48f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Sat, 10 Aug 2024 15:10:11 +0000
Received: by hermes--production-bf1-774ddfff8-tttts (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a9dca0509eeb7d45e9a13c25a941c594;
          Sat, 10 Aug 2024 15:10:09 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org
Subject: Re: /dev/ttynull and VT-less kernels on Desktop
Date: Sat, 10 Aug 2024 11:10:08 -0400
Message-ID: <3312056.oiGErgHkdL@nerdopolis2>
In-Reply-To: <24283318.ouqheUzb2q@nerdopolis2>
References: <2708910.X9hSmTKtgW.ref@nerdopolis2> <2708910.X9hSmTKtgW@nerdopolis2>
 <24283318.ouqheUzb2q@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Monday, August 5, 2024 9:16:21 PM EDT nerdopolis wrote:
> On Sunday, August 4, 2024 5:45:07 PM EDT nerdopolis wrote:
> > Hi
> > 
> > I have been doing some testing on VT-less desktops. I brought up an issue with
> > how systemd was not logging to /dev/console because isatty() was failing (in a
> > thread last month which I kind of bungled by accidentally sending the first
> > message with rich text enabled by accident) I solved that issue though. As
> > disabling the VT console causes the default console to /dev/ttyS0 and the 
> > isatty() calls on it were returning false.
> > 
> > I have found out that this issue actually already has an existing solution in
> > the ttynull driver. After enabling it, and then adding console=ttynull to the
> > kernel command line, this allows isatty() to succeed on VT-less systems, and
> > now systemd is able to correctly log its status messages to the kernel console
> > on VT-less systems, without needing anything connected to /dev/ttyS0
> > 
> > However I have two questions:
> > 
> > 1. Is there a build option to make it prioritize /dev/ttynull over /dev/ttyS0 ?
> > 
Hi

So I was able to come up with a hackish tweak, making a CONFIG_NULL_TTY_CONSOLE
it would depend on CONFIG_NULL_TTY being enabled, and CONFIG_VT_CONSOLE being 
NOT enabled.

and then doing a 
-------------------------------------------------------------------------------
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index dddb15f48d59..6950118c6fb3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3728,6 +3728,10 @@ void __init console_init(void)
 		trace_initcall_finish(call, ret);
 		ce++;
 	}
+#ifdef CONFIG_NULL_TTY_CONSOLE
+	if (preferred_console < 0)
+		__add_preferred_console("ttynull", 0, NULL, NULL, false);
+#endif
 }
 
 /*
-------------------------------------------------------------------------------

It's probably not correct, but it works for me locally, after some grepping and
guessing...


Thanks
> >    It would probably be neeed so that distributions don't have to worry about
> >    the logistics of adding that to everyone's GRUB_CMDLINE_LINUX_DEFAULT come
> >    the eventual day the decide to go VT-less during its upgrade process.
> > 
> > 2. Is there a good way for the userspace to know that /dev/ttynull is primary?
> > 
> Hi
> 
> So I think I figured this part out, while ttynull doesn't make its way into the
> /sys/devices/virtual/tty/console/active file, it is reported in /proc/consoles
> so I will read from there, seems like the primary console is always the first
> line, so this part is solved
> 
> Thanks
> >    "ttynull" doesn't seem to appear in /sys/devices/virtual/tty/console/active
> >    when it is active. Which seems like it could make sense, (as in a check if
> >    it is empty) however if I boot with "console=ttyS0 console=ttynull", "ttyS0"
> >    appears in the file, but if I boot with say "console=tty0 console=ttyS0",
> >    they both appear in the file. It would be nice if in the first case it would
> >    report "ttyS0 ttynull".
> > 
> >    With Plymouth, when the primary console is /dev/ttyS0 instead of /dev/tty0
> >    it defaults to serial logging instead of showing a graphical splash, so now
> >    if you want a graphical splash on a VT-less system, you have to also specify
> >    "plymouth.graphical" on the kernel command line. If it could see "ttynull"
> >    in the end of the file, distributions that go VT-less can also just enable
> >    "ttynull" as the default console, and Plymouth could use that to
> >    differentiate between VT-less desktop systems, or systems that actually want
> >    serial logging, so they don't have to change GRUB_CMDLINE_LINUX_DEFAULT.
> > 
> > Thanks
> > 
> > 
> > 
> > 
> > 
> 
> 
> 
> 
> 




