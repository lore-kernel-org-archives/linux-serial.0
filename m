Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F24401A18
	for <linux-serial@vger.kernel.org>; Tue,  9 Jun 2026 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005767; cv=pass; b=TH6vlS1/liQpTfAciBIlWtHJE6nvbeytQqywkXveNFN3V8QnKQjV2jka9YsqjNff9WHd/7kNO9iN5KIJd3oj8nDO/WRRwRdqAxCAUma4PTeXkT9FgcjepocaHrlnl+ZIJp8R+tpdwtteetjxgUedLtZHCsfuWGBhJHiXWe0wCTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005767; c=relaxed/simple;
	bh=TJ4EKfkp1V1jdqyjkkywZIbRO8ENV/47s6cLrib6ELc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SWNmUgTZJagnbY7lTIemRYW+i4H97awFS4CE1RYOeqnBZjvNzfN3Kyk6LIbMxlo1vEMUbca/BLOSEgPN7NpGCyBuedjRThCuSThuV70h+pwUxgsRXoisvSB6fWpTZzwWZvtVQjt/PEm2xIXStVNsUvrU5+ViqY4rTkCCkkivpis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kq8mmozP; arc=pass smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kq8mmozP"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-91587626ae1so618907085a.3
        for <linux-serial@vger.kernel.org>; Tue, 09 Jun 2026 04:49:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781005765; cv=none;
        d=google.com; s=arc-20240605;
        b=eWKGnCTItAL1yynT/uMBxCMmEBFcMz01//+vRJzgKjqFeoONZaH8LqkIlJrQXmywbm
         XA9BfyjDBH0A/nn5qdb72BdpCnd8sPyOFA0P32rQ9e8kXJow8iEHxLLdUAsG6f4ceNVc
         0YAg7lC08O40PHWUbMsV4f4EY0SK1tvRbI7hs5KLMWgk9OgloMaDpemEIvmthzaFIxHY
         r11J1o4oNX3+d/FzYb8EFoo6ZfpoNerSXbFCUkwU1CYdVhXzbhG1ewc3d/GKl9QbwNB6
         F73TxJyavHVBWG1qArQcI//fLY0Gs52LehRezE2VuzGPv3DIilqUVTxWNfRXLlIGqHpt
         MjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=iI7ci4ejd5MV0cL5aE5Looiw/fGjL4WsckOq/+KZsbo=;
        fh=bQV7jGNonwiIIjFKAkFDPWsq2Z0c6JLZ39Miz+ptQpo=;
        b=B8vNkC62GKwFIPKF5X8dgGgZ0+5zS9JdRbT2mbSiQ4na0VB7yVT46rCW0GK4O1HD9g
         klj3SvrW87JL620IYhQxiHCj/gqxuTEqgVzNe9/grfkNOp5yzvjIZNRoNrtiwqbJvCZK
         UtsS+2lTXx77TSHZBR+x0GLfnOkU5e4NxhJet5OYi+nrvjw3AaWrket4ir8xWXwoKnGu
         7ioe49ayN/PJj/TqfphhDBBufDb+eETh++JMbOcKUchTxRmKiZBqdu/h0eCUdYwnEloS
         kLXt1f1eqNVEox6Oyw+y70zS9MlZ4ziSQgDRcFEvnaofLClHZjhLSyVS2NUPudCb9MCz
         kqtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781005765; x=1781610565; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iI7ci4ejd5MV0cL5aE5Looiw/fGjL4WsckOq/+KZsbo=;
        b=kq8mmozPnKv+euxO4cfp29Vz8ZG9E7uK0MiwsTckvl6JnjICvBnw+KZtpbHoc8fDGe
         saRdV3RjojwpJHYxpoA8VgbUd1ass4gA/R9C2ef30AwAgNSql/v/r/q5TGVY/lmfaNzV
         hRMu78ovii8V/G/hF6NcQQE0JZCiF2ZQM5pHNfisbPExFsn5XR75EPtzS2Cp41lJFgBK
         BqtG90X9/anGraUEHLOo0RqTcNNPwKXXg+CDuHf+Y5wJsJDgvTGlUEb3EogZGHfNVB+h
         G+TKF0JC7efo/TEFYFBFFlXTxljtuZRt5cuYfuiYjZiQexLYEEVD3eKLhX4vWYrfEBpB
         FMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781005765; x=1781610565;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iI7ci4ejd5MV0cL5aE5Looiw/fGjL4WsckOq/+KZsbo=;
        b=HaLhFeh9BwpTDirTfyU9NTXv0FUQPOMgvX+odbco1WChfipr6AdnlSHjLpkNcgZw9D
         qaGQv8WFPRCH7cv+PUFh+nCN7Wl3RNr1AutMzq9xJDMvOIJA5dX4jdWPl4Ns4FqiL396
         6BTLbzV7ibZjJ3qBaONRnmxtBL/qpi4UkfrPQTfw0qhGjTipMaCGHDAcW/RVunMHw/h1
         I7SBEDFlPV06ZncqazO5A3BNs9BikzoEdJffp5aSKwxlMaQum+Im8VtZXSxdxWHpvl2d
         EdYMeKyppzs8Vmcbxp3ntEYpPeZPrJSgSTqDak/Jw27xuxv+1xFXbObVc89B7gLvNZX9
         dVKw==
X-Forwarded-Encrypted: i=1; AFNElJ/ZJV4eYjzmndJA3oZEwk/1n3eS6sDD809pNDLn3/0pBPjjaq4+SXRMPoSOKLuyrvTzzM1oQGgdFZ73mJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZh+9ZJ+rYcIDGdYnk2/Andy+YLfu4GtNJlMu9gXVVnROXlKTt
	vWWBTcFDnk0pvpJjvdg/ilcDY6o8+4hHCkPmRfIrqW2PCwQMpo6p8HWML01r3kxZhhaWr5BEE6I
	t/FkbGIToAUwxEsHUe48w1b81eyamg4s=
X-Gm-Gg: Acq92OG4sdClhZrMEUT9RUCCcfLZ/JvRKBjJjLsNxBc5oGQzWyfZYdx4zp2tMM5HqXB
	D7/3DeDo+gokDGqYjxC8xMbjh6Nxq2REjtAGQSIR32EaTxhbKzwiriL101C5SNCoreBMq1BQ5+m
	0PV4qRBLKVKOQyCTHgSeQPbwU2ToKTN0SwGcx59MDrpHfG+E/hLEWC3JxfMDm5vjj6gH6Au1Pra
	uMH2RIfK8eQ96HDSLsLePdWS4SfDDUrGBCkH2Ks9G2OfzU4DWNiSY/JYqF21w3CQfYx3dhDURrS
	TdPpcO5regAgEMeyTw==
X-Received: by 2002:a05:620a:46a1:b0:915:86c6:8438 with SMTP id
 af79cd13be357-915a9cdecebmr3152183485a.25.1781005764907; Tue, 09 Jun 2026
 04:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Longxing Li <coregee2000@gmail.com>
Date: Tue, 9 Jun 2026 19:49:13 +0800
X-Gm-Features: AVVi8CcFUeNtUpxxOT6V8STT1E4ee9Xm741llFLhVW7pNt_yOPBtE8OqqsmuKoQ
Message-ID: <CAHPqNmzFQPFCom1Ng-FhbeRm=maLsKW1T4ZasGm40OkrxJfuwg@mail.gmail.com>
Subject: [Kernel Bug] INFO: task hung in show_cons_active
To: syzkaller@googlegroups.com, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux kernel developers and maintainers,

We would like to report a new kernel bug found by our tool. INFO: task
hung in show_cons_active. Details are as follows.

Kernel commit: v7.0.6
Kernel config: see attachment
report: see attachment
C repro and Syz repro: see attachment

We are currently analyzing the root cause and  working on a
reproducible PoC. We will provide further updates in this thread as
soon as we have more information.

Best regards,
Longxing Li

==================================================================
https://drive.google.com/file/d/1Bx2unEf-QntjVi8g6Zw7QNO6OP4cjGO_/view?usp=drive_link

https://drive.google.com/file/d/11hRSaOi-v5Ova5uFzNwCHD2qwF3C-dTV/view?usp=drive_link

https://drive.google.com/file/d/1VsRjuOkgL9Gp3uqRFVnCg9V4KUWLsVYP/view?usp=drive_link

https://drive.google.com/file/d/1P8ALUdJVTdZqwWjlLv11As0b0qJEp1hN/view?usp=drive_link
