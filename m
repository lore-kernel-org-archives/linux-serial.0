Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFFA1C6FF6;
	Wed,  5 Mar 2025 04:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741149022; cv=none; b=F+IThzSbemfzs6omCHpOeGoAgto0ylZdFK5wNR8IT61iRtsfp0mQ8U7AhyQab+Zya/hrt4OAAxi1+o+ch5Ei7nV49CXYP1kHYavxWmc1fbDobOaE51MHSepbBQk2CXJwQ2J1LqYFBn0apb4plxEEFhpSA9szxDcRDmGW1SOXwMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741149022; c=relaxed/simple;
	bh=gRv7CV35Y+wxD8+twcYg9frzBTRq/XFnU65egWn7k6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/FvMPiTOh+1LMRyOmh2kQMIh3JEyJ4+243/7Vg+ASmVufOhLBQ2SDKkyzlPAQpezAduluGLL3034pqxx/tezYh+BpQgSHo7EXCi4oUNetYE23vccw8Um2Af/NPpFIx0gJyujvqoQwtgZPgnCnr6+9yxP1kNw1bKLYcm+qDUMrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwT32YtR; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwT32YtR"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c3b63dfebfso314966185a.3;
        Tue, 04 Mar 2025 20:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741149018; x=1741753818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcg5+dUnqHObtyvwEawYvLNi2iYwLJnPZJ0YScHoNmg=;
        b=mwT32YtRsCkV8ccMrIy1WveoREqBVRQgWn8vdnoUVbLsyax2NfAWcXtte5MYmaZJ89
         iDyiO1SGxtvwKzVIldAPNBTc4aLBkzK6anhIQhTdvYdFGj8BO48OwMcxDOWBKiE2uIyC
         /6aoNW4U8WdMe7yQwSEP3yF4P8p7eBvgpxBuFX6qNSkNE0x5m87kEgS+1NFk+W2u2s4Y
         39CSbM74/Ue+QZ6EA5OtKsi6oxNKFXYGC5bzUhkZBUMelWDWaRJlXjE5tcQ7VG7D23Fd
         ZaAgjOt5i1vhNxWnEwwCRHbkpdnUTeeZtjTN5+aYiUI3+g9c2lk6kWZYjc1yvCcHnkcw
         c+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741149018; x=1741753818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcg5+dUnqHObtyvwEawYvLNi2iYwLJnPZJ0YScHoNmg=;
        b=G1YYplDBtaycTRJEahtPwmo9Gg90HedvKd9mnO/7trVysn7h5rz/xhcf/+PHJ7cI/t
         CblVQfR+U7Ip/Gi3ByqU0bxXoJcRnCVOq9zODWTpWlwrcEJ2uKEt5WKQaSeAdGYreFRN
         KrQ2TqMsO/8GtvQ94s07fcxxoQlOEETXhL9XOE25ymSVskw/GSSXau0ucVqw3gIDtTNu
         OgDThJ14udQr60tiFlUiEbu9zW1GW8UyVbuoffLwQve0uArLjpYKUlMgYSx5AdbGyjmy
         uyBjXHjMG0SEyKd7ASBiD0/+ygsu43bTfzInkxJszXdsAnTvu6rUN3Caon1LdZ8VXY14
         DdNg==
X-Forwarded-Encrypted: i=1; AJvYcCV/8Y6oZ4SlKvjX8EUv1VToulGXnJSdT95dZco4KylIJJXDo4CG2m6D7Z4XFbO6V7gxG7eYA7swP8YfqMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYWl8xnT2TixoN/KLZkjuLGO1Ey9Nd+VI/ouVohqel6HksBsbZ
	4F/bYjIXx0AgCope/2iS8Kwy2HFRuySUhLwdEVoOHp1i/7IE/X3utWc7jR3F
X-Gm-Gg: ASbGncsriP3c2tkfoAfPRhmT52Vwy8BUfSRayIy5+U4rtl2ErDjJeUoeRHQGcUfjTZw
	Si5/yPrG6FwpyX6QpqR8T0uqt0w74f4UTSbZQUBEHL6mABOY0HiyJ5VZxfgUu5QAHvCojOIQWoj
	ByEJffN9WiFyZGQB95Ovab7VKa0u+4Y4Tq9pu9BNHqrD8fg/x9uwlfAoO+bGX4GKKUMOArzw+U6
	T7O0a7zNmsMSna0QuWT3DbUd5xsita+7oJ6sRlJfzx/+ZhsLTUCeAjXv0lBCMvqZTbcIcffem3/
	tcprBeWDpVFoaAGcaECMxIohF6opPMZytFp5VZoNX0OiRJmPDZ+XtLbqQuSz/vt3u73Gab+8j+q
	kvntBlpw=
X-Google-Smtp-Source: AGHT+IF8N0NTRr6Ym77rQ/OGR9PWcy55U0ei0cNEhjSrmW9NbsJLsCiFF+iQ4Sbm5xWterLY2TrNDA==
X-Received: by 2002:a05:620a:6285:b0:7c3:d32a:2b6d with SMTP id af79cd13be357-7c3d8e66d8cmr340642585a.21.1741149018595;
        Tue, 04 Mar 2025 20:30:18 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:a5b9:4b66:4113:9357])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fee8b4dsm834060785a.15.2025.03.04.20.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 20:30:17 -0800 (PST)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Petr Mladek <pmladek@suse.com>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH v7 1/3] ttynull: Always initialize console index to -1
Date: Tue,  4 Mar 2025 23:29:28 -0500
Message-ID: <20250305042930.3453265-2-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305042930.3453265-1-adamsimonelli@gmail.com>
References: <20250305042930.3453265-1-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Simonelli <adamsimonelli@gmail.com>

This allows ttynull to be considered in console selection.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
---
 drivers/tty/ttynull.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
index 6b2f7208b564..d8b51edde628 100644
--- a/drivers/tty/ttynull.c
+++ b/drivers/tty/ttynull.c
@@ -57,6 +57,7 @@ static struct tty_driver *ttynull_device(struct console *c, int *index)
 static struct console ttynull_console = {
 	.name = "ttynull",
 	.device = ttynull_device,
+	.index = -1,
 };
 
 static int __init ttynull_init(void)
-- 
2.45.2

