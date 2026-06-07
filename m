Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14E138C2B8
	for <linux-serial@vger.kernel.org>; Sun,  7 Jun 2026 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830559; cv=pass; b=rjfs1YXHgVV6u+6OSWk7D5xhtLReXWpqL7ZTmK4XKT/Np1J0xmvNb6g4mms6QhDfTVOg+m1EBrxDNFqR4R/qcmcBc6NzpVgcTAqG4HjhAnTtXyQivlkTKJ2Fp4oKE34LuPbYK9+LMs8sa67IomN/bsx3jAUYx3eTtQTDnD1TJKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830559; c=relaxed/simple;
	bh=rgXH0r5Gp7+wwiZfMZk6A/zXiC0LIjdrlyGpLiy1foQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByPPA88jqexQudtCdf1p/e1axHsefRjNsPwUk3go2W+yNsB6LovOqxrGdl0OuV4HGuVY/uVJXwfJ/80VPvQI/ECAhQiV6K83d/K+/ybmc+QZHIeNFwcAJQRU8Scy3kygdUdVadOfG6hZ1/G0aH8LRZzo09Z07KMMSxHHbuwD28Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnslrNHY; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnslrNHY"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66061993121so3103298d50.0
        for <linux-serial@vger.kernel.org>; Sun, 07 Jun 2026 04:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780830558; cv=none;
        d=google.com; s=arc-20240605;
        b=TM1594jkg/j5S4S+ZjNG4RNXX2qDJYTJ72L1yvQmKgjHcztaEOZljO4hK2N+SZeI+T
         i+SPh+RH8mCmkuH4VLKPeM0hHq344ROTZV79mvDtMuY8SLW6uMOwQRQAg+pwzW/UrfpZ
         tYQt6cg1WPf/UEbZPs35tkYafZNDYj4/1E7ZMHI+3hPT7P2dYyP8NCi1EdVjg2vaKbx6
         aFxJAjRIRQ96+F3tmlL7iol+XsXoCngRavj9mJnrP4diQw0dTUA3i5tp1Boow3NmQCoM
         SOfhXWXs9XjNupOUbTDl3kCougE/sk86cyQnzJQnV6vOgENqZEL9A0bDOV7UX4AerAGQ
         cyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AMcBvmzfa1N8OQr5Gy644NR4XpY/pQ/EeEN1EprEy0k=;
        fh=80NDBT+T645Ezx+8P2wnZsMSPrfvah4rbS4tM4wcNm8=;
        b=TBVXlkPwaDerHuMqtpbQ2vBZlLtGXSeOxhLSrDCfIXkfIDbe1PRg4HVYa1NHAMtMYv
         XARfNQon2a5Eq0zDBLwke/mcCl2AbMkpaEvCutgVAaYJNPUASu9QyF47vmNfU/3//ZtV
         yLVJAkJU06EaDOz2MZAHjE327t5FCjkXtc3/GsLexiIgGuRbnWLy+1VAItxyxxF7lfuM
         q7PHhDl5GAXaJWzvNENeFg50+eBwQfRgETcHITdcbisGfOP4K1gywBsmO4F6pGNEI/Gg
         4GbZmQ2uSL5FSR1ErMMDPupP69xCHEHeoQDrtdUIDLvkn3UcApMdGidE4Z/f9wXAK0LM
         bB1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780830558; x=1781435358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMcBvmzfa1N8OQr5Gy644NR4XpY/pQ/EeEN1EprEy0k=;
        b=pnslrNHYWHSYYNNb5ImEyt+y78GLdB+etOJW0GdV7qJjHF8v7Vq0nGoq/TyXlvAPfW
         tq4/1+JQKDbOxLrbuK7c9YLr8Zfes2q84/kFn1Qxz+WCs58KkVSXrcE9RBUjKa+UAOU7
         5pbYUCJMcuMC0Gp/tpBLK0cjKSPWd5hAcqnnnits+/fDtreIU/5204+mtgXpNixzEMuY
         h0K+Gu8pKxdaawi371RqnHCg/aEDtKHWZcEQMbndO+5ytTz8ZP9XlW/hI/Q/8SstUL3h
         B5pg1P2Ev3F6R9UK1pXv5JlGREr7iLdFAMI4wESQWo2Xfe4fw4L1vUnn+Mv6qUsF7qX4
         IdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780830558; x=1781435358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AMcBvmzfa1N8OQr5Gy644NR4XpY/pQ/EeEN1EprEy0k=;
        b=FTBfUNvEcrjbWzkW6xn9euPobpfMYaQYM5OPvm89aiHRTdPwvGpxOEY7rCvjOrC2V2
         eADrWDiuj+EdzGehGlf7xtLIxLa//nQUWD0JQuxsIOOkyDPCV7nR2O557RGgE0paYqtW
         53ypvkSiMrXL72ahT/oORlyzEQxmjT2l0RZ+ypQDeR6X+IDl9Q11z9SkFCwo73UrDJZx
         eNS/OUnbUdmsWQgLEZ9ODcyMQYywniXSxVI1LHjo5rMJfHqS83IirhlQ/iP6qkSPsMLk
         tmZXdzRxg3ARlijTD6nAzlMrjQIvx4cialKg9hhUSMROO10qFbgJWpxt/MXWtdO8Uows
         EJMA==
X-Forwarded-Encrypted: i=1; AFNElJ/2A7k5EQ4svJHNcmj1p2fa80Ifwm3VvaZ9hRqFkYwNBYl5mRB2I8vpSAyOsyJlczxipKciu/G/QxxeZTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpBEeMWx8TLGp3il81vcqGByIxBq9V3kL2rKrkYWwlzNkSkAxN
	i1J1fQHSHMkJc+Td4WXxjvuZxBIXzuqTUgUbtBDp/m0ZMlwJyFPbz2QMa7JUGAl2XAMOUjbkK33
	/RtPSdpxhlMqd3i72klvcSJFZoWIr//g=
X-Gm-Gg: Acq92OH9sm7vGwIn2BL9jfo7G8mW5fvh6HFNRaXefnN/xNM+0dS0Hho+0v0DEcWZX/+
	zRqGpei6WVpk7uQVlZXnu+mz18LpAaMXVBBFOPm8nWg/d4Bo7xzM7l433tr8HbRO9tCeAsuGTq6
	jz2pO1Hg3aKVwINI7M7V2dl1Egr5D63sSymieyH8X9Z7G943RRDPDXMIt3banp0ZhXzbLATGgLk
	Yuwow/mm5ajFRZ5bDf++ST+LRIVm5grhWPUXbp4FMr8n0cIwDt4SszrEqEUP36XAQdZQOXWxRNR
	LYrJXJYhQZP07UG0uL4iRkBX6sSSzGaz6++1tXH5JKVbT+E=
X-Received: by 2002:a05:690e:4397:b0:65c:2360:dfc8 with SMTP id
 956f58d0204a3-66106e38366mr6827437d50.19.1780830557693; Sun, 07 Jun 2026
 04:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606170323.1522340-1-michael.bommarito@gmail.com> <2026060715-quarterly-dexterity-982c@gregkh>
In-Reply-To: <2026060715-quarterly-dexterity-982c@gregkh>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sun, 7 Jun 2026 07:09:06 -0400
X-Gm-Features: AVVi8Cell3x5_IJz1l-VtC8xJj3FqSM2UlNjiiWWbJ0v4m9vLD7yLc3_1Ec1dNI
Message-ID: <CAJJ9bXw46vThuvzE-x73unRDm8n2ibq8+KF0+YO3gtipf1PNkQ@mail.gmail.com>
Subject: Re: [PATCH] tty: n_gsm: bound the EA scan in gsm_control_rls()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026 at 2:38=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> While it's fun to throw LLMs at this codebase, how was this actually
> tested?  there are loads of documented "problems" with this file, but in
> the real world, with real devices, it works fine so without testing of
> the code with those devices, we have to be careful with changing
> anything here.

Understood.  A few different notes for you to consider on this one:

1. This is almost certainly the continuation / completion of
669609cea1d29, where two other sites were similarly addressed.  I
think Daniel could answer if there was a reason why he didn't include
this spot, but there's no evidence in the commit log or code comments
otherwise.


2. The backport situation on 67c37756898a5 (the CAP_NET_ADMIN gate)
looks complicated because it wasn't originally stable tagged and
didn't get actioned by vendors for awhile, so I think reachability for
unprivileged chaining in attacks is still high.


3. I'm normally running tests on UML or qemu for every patch I submit.
Sometimes, the AI assistance tag is more about the testing side of the
patch than anything else.

For example, for this patch, here's what Claude logged for the
regression testing:

<CLAUDE>
  repro/loopback.c stands up two real N_GSM0710 line disciplines in
one UML kernel, wired back to back through a userspace byte relay =E2=80=94=
 so
the kernel runs both the
  initiator and responder TS 27.010 state machines (not a
userspace-faked peer like trigger.c). Phases:

  - A =E2=80=94 DLCI0 + DLCI1 SABM/UA handshake (kernel both ends)
  - B =E2=80=94 bidirectional gsmtty data, byte-exact (PING/PONG)
  - C =E2=80=94 drop/raise DTR/RTS =E2=86=92 real MSC frames =E2=86=92 peer=
 modem lines track
them (before=3D0x0 low=3D0x40 high=3D0x166)
  - D =E2=80=94 inject a valid CMD_RLS (clen=3D2) on DLCI0 =E2=86=92 accept=
ed by the
patched gsm_control_rls, mux keeps carrying data
  - E =E2=80=94 clean teardown
</CLAUDE>


4.  Relatedly, I think it would be helpful for someone (Willy again?)
to improve the guidance for AI assisted testing and establish some
standards for documentation.  Because most of the kernel doesn't have
established KUnit setups and dumping all this info is frowned upon in
commit logs or notes, it seems like there is a tension between
"showing your work" and sticking to general convention.


P.S. I know it's somewhat contentious, but maybe one of the best use
cases for AI would be helping maintainers add or improve KUnit or
out-of-kernel test frameworks.  I have dozens of orphaned tests or
harnesses across the kernel now and would be happy to contribute them
or use my tokens for the cause.

Thanks,
Mike
