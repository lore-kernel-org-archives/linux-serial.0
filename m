Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6E8158870;
	Mon, 24 Feb 2025 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400791; cv=none; b=T1ueAKORuc+lu//lC//D9xJx2tvGxxNK8JR3Jv6p6sooZQ0PMokdbmLuxQVXiQc7hEyQ5JR1NthEA8CBsiVD+nKOAd656as0VkJ/iZhE4uqbDnIUcZC4a+/xSNDi7w81udcLQMS4EdpOCrbCMm+s47clefjUyEpo2a5repcDQ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400791; c=relaxed/simple;
	bh=M7xfGxE+1+9CnrKKPeCrSKVuWSa5PClicD3wQIhbkUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C31PXTVCdKzrvq+Nc5YH7wLDJpAYTpZqxBxNLqYNm2mbmkqi7AWYqUpJ3wteewZ9nioxpYTq9iodhXyA2PbJz0r4PmqZEJM1AVv9oz7W76wHEZGBw0aEFwW9tdByx+Fm/w/NLiVXeve2FIViRmDs7d8uY2j6F3nQEB9Ffdl+C0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElD85YUo; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElD85YUo"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c0892e4b19so525109585a.3;
        Mon, 24 Feb 2025 04:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740400787; x=1741005587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LzSKwUi9mVzdzy8b78pt0N9MM54Qsm8BhYBMY8MEQ6s=;
        b=ElD85YUo2sBklKUE63shtjR9Ub3fVM5bNDx2MUQcmC8mB7L0Ebuyv1VDkoRO+xgbsK
         zPx16nO2eghGbyKYOMgBEYA5D5XSt5sNVKNINDGLUA1xtXP0XOdvq0q2QPTay6TAc5tf
         VPrxPDKCHWVmkwGaS+2V2Aox1TJ8pJc6bfHPXS10/SrATIUepuyayKLjA/u3FBUVvSe3
         e9eceXTXHygpTgCqsIb8DTz4VjFTfNcSl4cvLhhpCrSpB4uAb33EK0ADyZiw/3tcv4wT
         L0iuKNBCcgocICOdbSpbYmjQp6BqlWjSH8UyDpbthdcWCO4SuRLT15ChJuysqiOk3hVs
         mP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740400787; x=1741005587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzSKwUi9mVzdzy8b78pt0N9MM54Qsm8BhYBMY8MEQ6s=;
        b=OAuDR+rOkyXg+yCG/ZEKkQcYYPFmE5vI4/Ch8yGu/hLO42IAXgl4HtWOsZ3pVf3+tf
         UG57ZmTZH/EvMJv6Ta6dQjJ/ntB8nVbFj/BOy7SPqqCXHe5q5fo7TwgxNe8QVWyc17D/
         +GIU0dACs9hv88YtC7dItBrfLTDZPAs6K3U36XiHwZch1PlanE7iiQm94nyx4Hc0Acg/
         LirRmu2bBPPJceXxWrdu+M9Al654pNXa7XZm5HZwf56XAaVGObUZafZJHhEDP0ahz64b
         PESQnmZ6xPje8czPqU9tTi7Y9Km2FGnTsWeckXraZ8+kX+G6IW6AbRddE7/hwbrI8Jbg
         WvsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnGGkkxNjPmz8bziRP8TwvztykGDX8nO5WZIFmnwKwBqSbhmY3l+rxa3ySfnNz2QplSIFXjYRHVHy1Ugc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWfq+FjPVcxQQ1UA++JBPFf7GtRMiagcrMgsSviDbJrcbNSh74
	20Glc4VjrS5wgtGRVD3BisV97AT/IkOXJsTWh7O0pBNjuRdvFQvpT9zc008j
X-Gm-Gg: ASbGnctzPSx/sipU23fUxXWdX/91tfaVWv64zwNojutvejK7TcDmgoTHtXzXoQHlhBn
	kfpJgH9it1x/vrPdYp0pxAIo/FQZRH6BvUQ8wJGpT6TpQasbWAzDIL4F1Nxb/0SyaLL6MfUz3P2
	RE0wxosboO6YEoo/E3002Og5AXc1QIcnTU1+rTZFqPCRUPLTBnZVGAnYp6zugtkYd19jCvv5D1k
	Z2RI1IBTPCfkeQg+ssJawZtuO1RhCv202OpirKmvb9Jb/KctHBCusR6MOA1CFHDYllUp7cDk3NF
	IHEZuy9/UgOeROMAb5stteJkuyFzL0NR4u0SdTJ152n2ERt1N3cjoV/GCAkWZn/P
X-Google-Smtp-Source: AGHT+IGrtikCg+RcBxZv3Glu2xPqW9W83hOhQsGqRrWIK7BYTk9UUmQnFBpKAnwUlxpcf+JkowjJBw==
X-Received: by 2002:a05:620a:472a:b0:7c0:82c8:e42c with SMTP id af79cd13be357-7c0cef64787mr1834828985a.42.1740400787597;
        Mon, 24 Feb 2025 04:39:47 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:3cb7:1064:72b6:f891])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0ad774f81sm831922785a.37.2025.02.24.04.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 04:39:47 -0800 (PST)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH v5 0/2] Optionally allow ttynull to be selected as a default console
Date: Mon, 24 Feb 2025 07:39:13 -0500
Message-ID: <20250224123915.2859682-1-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Simonelli <adamsimonelli@gmail.com>

When switching to a CONFIG_VT=n world, at least on x86 systems,
/dev/console becomes /dev/ttyS0. This can cause some undesired effects.
/dev/console's behavior is now tied to the physical /dev/ttyS0, which when
disconnected can cause isatty() to fail when /dev/ttyS0 is disconnected,
and users who upgrade to a theoretical vt-less kernel from their
distribution who have a device such as a science instrument connected to
their /dev/ttyS0 port will suddenly see it receive kernel log messages.

When the new CONFIG_NULL_TTY_CONSOLE option is turned on, this will allow
the ttynull device to be leveraged as the default console. Distributions
that had CONFIG_VT turned on before will be able to leverage this option
to where /dev/console is still backed by a psuedo device, avoiding these
issues, without needing to enable the entire VT subsystem.

v2:
    rebase

v3:
    Clarify commit messages.

    Guard the all the register_console()s in ttynull to prevent it from being
    registered twice.

    Only change the link order if CONFIG_NULL_TTY_CONSOLE is enabled, otherwise
    use the existing order for ttynull if only CONFIG_NULL_TTY is enabled.

    Document why the link order changes in the drivers/tty/Makefile file.

    Replace #ifdefs

v4:
    Remember to actually include the changes to v3 in the cover letter.

v5:
    Correct code formatting in Makefile comment.

Adam Simonelli (2):
  ttynull: Add an option to allow ttynull to be used as a console device
  tty: Change order of ttynull to be linked sooner if enabled as a
    console.

 drivers/tty/Kconfig   | 15 ++++++++++++++-
 drivers/tty/Makefile  | 10 ++++++++++
 drivers/tty/ttynull.c | 20 +++++++++++++++++++-
 3 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.45.2

