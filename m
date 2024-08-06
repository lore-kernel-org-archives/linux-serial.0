Received: from sonic304-10.consmr.mail.bf2.yahoo.com (sonic304-10.consmr.mail.bf2.yahoo.com [74.6.128.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3DF33F6
	for <linux-serial@vger.kernel.org>; Tue,  6 Aug 2024 01:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.128.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722906996; cv=none; b=Q3DZvXnMDH07bFTITveWFCROwpUoDbnVR2oiyHdao80j9bCfogf7q76RGr6+9CbKsjr08egcM3c+az+StM2GykJpRCCgTuyHpBBOQbE66P1vl/4kA04RtR+5Ai+95/x34kVb/yTohc6oDmjZicOJuTQWflsjBBRANo1QDUMT5ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722906996; c=relaxed/simple;
	bh=XAAESQ/NRqwOPXEjRDEoy2Z0JG62kTed/CF0P/AwL3k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rq7I/oS6u29jKMfS2Uh7vePPsNH2SesGcONYnWWAts05cvK1KaiWAtqU7YvO8VoknsVdlx9vGmJ+CzvD/Ee1scnVaWVUCRiCC9eXK3jZTMaWN3wbIJnd1A/X1ybrBdd87tXTfUAWEtcWT971JSd53wCvt9KmQvozfk6Bfh1M3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=mc3OHSHp; arc=none smtp.client-ip=74.6.128.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="mc3OHSHp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1722906987; bh=VWEmzil3zLPDoms9iNFGh+/rwUxsuDE25Z+fgVcmYPw=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=mc3OHSHps3iO5/IYZvHK5bIbNt7R0k/JMcHM01b3lX9cmBGobiuS+S6VPv97oq/P2rMVRJrUg4prMqZQ79LoaTVLMBFQHlbb2He0i85kuLNN9VR7kEoy8QgLhj7OHk2HYor6QViyBTdizENNDDZAKuwLAdADh9+Uz1se8sanoEX76GoSX0uFTWmoSwPGnAGXkiKRtb+nArn1ABwIQTHqVfLF8G5e5xcuZR8xQYflm/+tArkWi+aHxbvwGAEO1kIyqPdpiFeHaeRjRYJLecFb0/DqxoFs6V9Q4vC9akqCUaXfUPp2Mg94xuywU4NeVBC4Ngf8eUD6CMeLILfGxjV+ug==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1722906987; bh=o0fNOQxetYqMBntDXWseA1nPRsopmpPieZMYnfbsA08=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CL0FlcIfJgo7LdHo92wBACrTxRDJlNgCdIZ9JQmezsnqZmCP+iyjEjGOgymrDPtG6T8sg/fyMRs1dIMEln72mFolW7o196T/7CCAvuSPeStu/HniTqykTDucpkDLqWVaWXBJnYI0rbCbriVxu+cpeLvn258dK3h+YmK7HYZTCH9sCXiBvfDcLim47m1Qc4pO87BoGlQghh9dHtlYKeljwyhb/ElFBIQguL6t/0Pf0m4aRFKLbStQBa1nV9jKeRKjLPveJbJDp1hRI1JdTyU0pfzNNMLuv8g+kqLJNAgXuiAApdXdL+HBryUiAznM+dzWChRJaTmkoVCdxRJe1X00eQ==
X-YMail-OSG: KBHqTxcVM1mBmsYWNpUM0NLks.5el8fuNqpdzQV_nQJnL3gtbpezm.FnBL9Rhwq
 2X7fxb_rvIkPGMv2o1pc6HXZF9wHqIuvtsTWMSebLY0eAjo3hx1.NG48CD5jb15ISkqj34slSRLZ
 cCNmoKBKJbS0VfSTeULsRvTBdXcYyP6YTe6yH.qbMcHUck6tRye0pSd9JrCACKrHkxpOh5P2qjKx
 pWRY0JHLHhJ19TFkEsqURsH.3.n5Os3Sksk0Q6BR03_7I8uzeQhys5bopvc1EZNeqALOw6b4Cvvr
 hUtdBl2z4nY31sWpSuJLaoQqNxzSFz72iaAHwX_lB3FLTnAbuDjUjfGC7pbViD2DODlkQr1BVvW1
 PiaGLPMdDbPUlnrXk2Nu7O2kSLfCTn1TQuhfTxpW.ChFirg08M7kydm9ggX9zqFxziwGQUHZnmSw
 2zH12E.vM_ZbKssVy3H1fRDBl.CwedmMx_msucGvCpG9YUaJ_8lk5Tik7Hcbylvv6zo01TBbe.bD
 3WEqaExQO2DNyH9xn2UXKLlRX8QxL_8uslccciwstedv56N6Q_IjwHPC74H0MPvtY7n5GcuX4yjd
 GN_4UtsNBRocsRst1TAQjZxmnz.uuX9grwQx5rIc5Gq__lZZpiFCK7kdVV2EyAkZBmtm7xVXgPvJ
 gUxd_MKu6MO0CHSWA.0G_rjScEQayHjS1oBx7O9m9UYpq07FWhB8BDT1Sy1JPaML6KuCkesz32OK
 C0zYkXVZdYwyK0HBq6U5cPEWhCfhuGT3uDxM8YccJHV2ZIh6TmymHB5y0pmO.tpDaOa.N2NW29tD
 q2i606U49eLT4PKQEuieqwS3JuFI7H3hgRj3oxiGvf.EAng5izYdPOwFaoBDf73slFClWDZOhW9M
 0fuCOL56gKgVnR6vJk_gsIJR8KAWo1ZDWqYwxXZ6epxoBBIJM9QP94YZ_s1M5GCYkJ9GJ_b9KiZQ
 7eRAluiGHcJBUMOKesS5JAAVTk3In_LUG0W_PnPzSveXCuek83kpSPY7NhjhRD_1PSh1asO4edqr
 HRiEWAHOdfX5VIwy2mY5556vqo12bE_YaNrxiagLN91VtqFNCHgq6LhqKO.GmPIqXwkaSOqcvG3I
 l1Bgf5bF7DqKlt5fOVONUuN7Kz1I9ijkNHa1S0qgOVVZZVUgu8fRCn34BkUph2Y9qx7TcYR9aUIe
 g6FKErZtu_1sbB8w2Hwc9yefnUNWj5nm4MfDUAHpKKL4VFIHITqcD4RgjCrDo_4AIf3lqYS8InV7
 mr5HlFL5t8y.CEs.IDLPgYRkYifKr7YZhXHGkAjoqPaWPqaTACYrahQLhirVZPkazyyUBv9O1jUV
 2A6RPyVkHVOXyizEtBuvy73UR2El5gQ_HXvpm5L7HK3k5GBERyo8hua5L16IFenTGy4dmB9YsKRu
 AALPWUpK9Hg7yRFoU8Fvrp5FwJVxcpDgd_Zz1EtTvAHUzG0ipCZd381UWAnzwsZwim1k5kxIzUMt
 md8L4m6b7fC1enhudjgz6MgUcqcpUtfrQPj9fpjW0yb4YllFlwp9G3cN_rUH9T0dCSVfChXSLDXB
 p_iUG8847hHWIAmEpY3Nn4Iahgs_LuWfTNeC1IkE9afzRUDCKNqDOVIXOi9indC.4VoECiQIXdiq
 1JVmFOHCutKEVX4nBEltusivGJ18WP4dCtt9u6MOJ8_d41CkrQdqi5BNEMM6CXp8lxSroZEOm0md
 1RGry3OdNdeaS55BVK5I4uRzJ_xEZ658DG9v9iUBsRQS992Rtq1GW0nc7PJg7Gon6YBqzU1YpkCw
 Rtq60Wvl57WSzgHV5zBDCci3NQwzA2wn1En60kxcN90EQtVOlYYZQT4fsqdzQT1A_KkAXjjAGb2Z
 Rtx1wVLMoxWJY3TDh4jqe0ll0AIdEVn8xVdOv4UkQGtLzdR2QZjJ3GfmVReFk0bkqVrYvYBd3hzl
 ind79.Hm40dYThnK2ULTfNf_Q17d6N3C4UToLfDneZ0QnGl7ByTe.b8OoWP2Vj3XP8mGgboBsRJx
 U5NvZI3GAl5vsZhUT8nrmntRwHVoC9X5gjr77rEK6yRjzpkGwrB0ADz9t0dZguIa2xHNCIDnfoKM
 EQTYQJ2y8tbEFY9Q35xsaR022LgBhhOSDRtPPFec32VNi3mrjNErG_hJPY_.8LSD2j4uZcvw7HvA
 ZGqnw8Bg707hNGJruRTOxrZ69toXGHSXy_Xi80.FjaSRnLb_kEkDk57dnJFvhkCW6bfDCyj.7h6n
 _dJ5q6_SoJnNngGrhVV_BjWs7r8aaYDRPzHQMFZWgYTyI_ZgZzZptu3L2g.DQfWKC7BI-
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: aeb93577-cee5-4bd8-a652-82803e05b9b8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Tue, 6 Aug 2024 01:16:27 +0000
Received: by hermes--production-bf1-774ddfff8-6qj8v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID edb53c5f1941843d2e18f3f890bdd8f5;
          Tue, 06 Aug 2024 01:16:21 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, bluescreen_avenger@verizon.net
Subject: Re: /dev/ttynull and VT-less kernels on Desktop
Date: Mon, 05 Aug 2024 21:16:21 -0400
Message-ID: <24283318.ouqheUzb2q@nerdopolis2>
In-Reply-To: <2708910.X9hSmTKtgW@nerdopolis2>
References: <2708910.X9hSmTKtgW.ref@nerdopolis2> <2708910.X9hSmTKtgW@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Sunday, August 4, 2024 5:45:07 PM EDT nerdopolis wrote:
> Hi
> 
> I have been doing some testing on VT-less desktops. I brought up an issue with
> how systemd was not logging to /dev/console because isatty() was failing (in a
> thread last month which I kind of bungled by accidentally sending the first
> message with rich text enabled by accident) I solved that issue though. As
> disabling the VT console causes the default console to /dev/ttyS0 and the 
> isatty() calls on it were returning false.
> 
> I have found out that this issue actually already has an existing solution in
> the ttynull driver. After enabling it, and then adding console=ttynull to the
> kernel command line, this allows isatty() to succeed on VT-less systems, and
> now systemd is able to correctly log its status messages to the kernel console
> on VT-less systems, without needing anything connected to /dev/ttyS0
> 
> However I have two questions:
> 
> 1. Is there a build option to make it prioritize /dev/ttynull over /dev/ttyS0 ?
> 
>    It would probably be neeed so that distributions don't have to worry about
>    the logistics of adding that to everyone's GRUB_CMDLINE_LINUX_DEFAULT come
>    the eventual day the decide to go VT-less during its upgrade process.
> 
> 2. Is there a good way for the userspace to know that /dev/ttynull is primary?
> 
Hi

So I think I figured this part out, while ttynull doesn't make its way into the
/sys/devices/virtual/tty/console/active file, it is reported in /proc/consoles
so I will read from there, seems like the primary console is always the first
line, so this part is solved

Thanks
>    "ttynull" doesn't seem to appear in /sys/devices/virtual/tty/console/active
>    when it is active. Which seems like it could make sense, (as in a check if
>    it is empty) however if I boot with "console=ttyS0 console=ttynull", "ttyS0"
>    appears in the file, but if I boot with say "console=tty0 console=ttyS0",
>    they both appear in the file. It would be nice if in the first case it would
>    report "ttyS0 ttynull".
> 
>    With Plymouth, when the primary console is /dev/ttyS0 instead of /dev/tty0
>    it defaults to serial logging instead of showing a graphical splash, so now
>    if you want a graphical splash on a VT-less system, you have to also specify
>    "plymouth.graphical" on the kernel command line. If it could see "ttynull"
>    in the end of the file, distributions that go VT-less can also just enable
>    "ttynull" as the default console, and Plymouth could use that to
>    differentiate between VT-less desktop systems, or systems that actually want
>    serial logging, so they don't have to change GRUB_CMDLINE_LINUX_DEFAULT.
> 
> Thanks
> 
> 
> 
> 
> 




