Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427EF23F26D;
	Sun, 23 Feb 2025 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740343505; cv=none; b=mfI/YMEfDMq2Xxu0pEuC57coZNGeSAqsFcMaWJ3TENJyvEczhYxV4K9l5YtD6w2IQMe1jC2ggLTvcn1vs+XhSxOzE4bWlMUNhoPvCvLau4C5LWDKDDyIXFuCmwwgueBJcolU9bfMnmAr5Iy3AWiwIgQ06/FHqqAVUWeBN5a2SwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740343505; c=relaxed/simple;
	bh=VKiUNQ2fDZY1Fc7UEMBZsZJoSXJqwzwBzeotQgNOV5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3fGpyVjFYKAGn4PVp1Q9LRDDrZAb5hDc3vXCinMwO6kLgn1DkhknF2O+45VMc1DIrzz6Vxuq4lYZve0cs9Cdc29xhTVlw+HZn/5xN7v6/mY/m100T0QaSDqH2/q6/emMI52v+Q14IwRSX+EL4dl7ncEdzaeXgDpV40VYXKT7Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCX/fPUg; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCX/fPUg"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c0848d475cso539027385a.2;
        Sun, 23 Feb 2025 12:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740343503; x=1740948303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V4of6Ve3wlgZEj+NyYh0JA2Po9Z6Yz7tIkuR6jnr7d8=;
        b=UCX/fPUg3KR7NM1H+xJcK9jJDgt459SjgBOwZ7xs90ilBeDBIVssg4RfOit7XhsUQ1
         Fap8FTKgStOhsgdHP+zWgGKWzrHUJ41JkZa5qviplwCNbHWk6nhEzoB0jdN23pP4CReh
         IYKuc+KEzw0VTxi8+6Pvixs3XsQVwg655lr+/mrtluo9n8maCUr8/RKTRl7EMDKibCbu
         F/la2b+ec6yCnHZ0zy6E8RjAn5jHSUfyKpGPoGpqXk6QRZShmE8yjAEWWlqUfJ+br/qi
         46pP9iW7MpRq8+9oHFMBgDZgi/A76z9W2LkZroMc7GC3BXGHzdkfqUHQZ8ojjMhqQqDJ
         AzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740343503; x=1740948303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4of6Ve3wlgZEj+NyYh0JA2Po9Z6Yz7tIkuR6jnr7d8=;
        b=OvMWQCfG2rW6yYRC6f9G6ie7og6mGyPkzVvO6WCPesEXaa/TgVZdTTjMJ0MG6nAmsM
         ReNrPPn46KSH+fLpj7TT3yuKPGtHEqeTHvdrYfkChNTPZAWfSj5tFv0eTX7EsM7nDIXJ
         ZUeYf2yxvvhbCnS6dTAtNS4KAH8fqwhQDwMDFiAtw6tPhi7e/BSghj+kBwYD6Mx7E0OV
         YR46m7FXGtBetE7ij5xe222EzC5pqtAHKMs3oLuApCuKDBT7D5ykhcCJzMO8c+pqQ/fO
         T7tfiyGIeUjbZeiWkuc3B3M5aHtHg6E3VdWjPboHgEUhaAsYcZtkyRvytorUiiR/8J3e
         Mkbw==
X-Forwarded-Encrypted: i=1; AJvYcCXMTla/f1rDWNIKy+/h+6dLTWedn16gkNlJjNQxLUQ1JASiz010ssxyCX6h8HPSMf4LsXkMhgir2N95GJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YybHsVM1HRiMLhlA4y3+BAY6A4ybwu3fd6arvsijgtyg3HkLDf1
	QJVxj9wIfN9bwDA1TWzJNghInIr5hZ5RsEyF4gXCIGMlAl/v2Qb2qCTIjYVa
X-Gm-Gg: ASbGncs/mUqfVmDLZNvMhh8YhMGztfOKBmES90MXJXHDrGgr7nq/nid3N86I/nQSMGD
	sjUoIzQC6beEgWjaiaQG/5/bVq3ARPtn2nevbsOlmdgydxcsPR4OJ89dETQ99GcEfKjFNGjZSMV
	BEbbJ4v0GTV6xgH1XGHFnaBZpIlIXxYr+nrWLd11GCfFdyd3z5uMFKisg9qsfFPndpUUYLRSKaD
	FmXj40ZzfmhBikwNPq0+h0dMlrlZfdAmhLHioHWrmsAvNv2KsvuU1ukiLaP0/SAazjHa7yR7qgw
	rLwhhb+Fm8TQkKrhfGRJnKHYxKVaYr7zVzk+O/gWmvhjy5W0dhrdxLWlTPo+E58=
X-Google-Smtp-Source: AGHT+IE4DeN2LSuvO+8yQTZ73arJ2wgyunYxWSisttFaNN/ZKuhdzEXOBziL9q1eBD9jSzbb/i+Ykw==
X-Received: by 2002:a05:620a:2915:b0:7c0:b3cd:9bc6 with SMTP id af79cd13be357-7c0ceef82famr1452715485a.18.1740343502899;
        Sun, 23 Feb 2025 12:45:02 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:7a4:75e2:6847:49c9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bc8819bsm919914085a.74.2025.02.23.12.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 12:45:01 -0800 (PST)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH v4 0/2] Optionally allow ttynull to be selected as a default console
Date: Sun, 23 Feb 2025 15:44:54 -0500
Message-ID: <20250223204456.1913392-1-adamsimonelli@gmail.com>
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

