Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793083973;
	b=KaBJeBEgjmxOWfVJH6RjktzBMVmpKCNUzNFdmrNbf37eL4oBtEK03cLDcC6j5QWh1x1X
	 bHd2+flOyU62k0DCqa23ieERqvkas6jG7BGJmBafLYnRh2gew0p9pzOC/JdAPE1GlbOmy
	 mbwczwUJcSQ59AtZgIex/NIer0sZVKqTASNd7yqDJMjRk1YnJAw0xJhCImvtTCELA5sja
	 IW4lI5+3KLNYAuxb0W9Pe4ekUaZPnu3mf6TkwnYSfhOgRanjjbOcVcmiW7ZIt1qJjX/Gr
	 MqfrP1ytPTrVqcOvFotsPEFTgKgyJsrBrprqj4foE1XPkHwCx1KrC+7kA63MoT824xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793083973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Bcuq2df4LWxKU06cO1cKfQHt7bV53cP3D5X0WMKpC5M=;
	b=Wg2yZ7q5nN6IzOuGPqiRJlxRPJP0w25v56dx5/OsnQk1P42pInzqB0pq+eju1dbpYTXh
	 O3vQpTDsS1b/isqXhLBFED2jO7+GEFnq7HXB6KEPBkSbymn71W/o6QcrLTGCj/Ghuzmfi
	 lYOMO7NPd1C0VZs3gJd7F/Slkc9bBKJEPo+LYRt+2U8dUQ8UOorP+HtlKNagtacD24ti6
	 B9JZK2xdYR4tnXZOW5GshZY9L+kj5bHTdaF4SFq2m3+sgRW7Mihk42nP+SUwtHRtAQUb/
	 goQDR0CN/WOpxBDG8qKPpLQ2305fMNeBOWvs0TN5DW9T+DI/4TIy3x27R6QwUTl8R7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CyVpYmwe;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A4606A31E
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 06:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 391A4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CyVpYmwe
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a215e64962so29156755e9.1
        for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 23:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793083971; x=1793688771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bcuq2df4LWxKU06cO1cKfQHt7bV53cP3D5X0WMKpC5M=;
        b=CyVpYmwexZ0bVEp0AP6HCD+adMbpynGOGrPpnbPVqkVSdUknZA4JinYq0I51kxx8Aa
         17jMEtKvvpyf6qJsb+JydH+g0gXGuN+gpDGCPywZi8w7SJkff9cmaY4GUC41TyRl41DM
         qD7lYaTVE+xOke0MyrzHq7xXdStA/EzCcFkL/dhcL1N/yvhuUCMLf4m2ph+ctGO+aI2y
         l+nhpfmo8m0zFLguHtoGeGbs5JAjWoVtefeElI/aiZd8obcTZX5IwfZSSpDP4nTW6Ut+
         b6g1/pCZedJSU4PX0NGcQqJekYsdDn1Fp4Cmw7tVPIdzIn5xFRARbGS3vl8i2WqWWLfN
         vnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793083971; x=1793688771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bcuq2df4LWxKU06cO1cKfQHt7bV53cP3D5X0WMKpC5M=;
        b=MzoiMs/7zmEFJ85efB3uRnl/tTozPch7EjVhShIsqs5LyR7W4CmUzNjiRv6UDZCsum
         JqDYF1zaMdwVyW7VCUDRcXs+txyCSQcmctQ7p0gZ0giEpRdYeHVI/dixO46QFaeT7CXG
         Cw8JRiGamtsrg+a0rhOD8wmc7rMuygMsYKNOEob5uPUe1TdO88HxlZkMVXMDG6DkWbmc
         L8XP9eNWOWYr9wmNKb8xiBQyU2hb68QMjTyt6uerkIosN8h4hEHpKQBQtzoG6jQBVLhU
         wVrf/Y7V2OQf8jM3ii4T4hR5qVrJBbIU2RRv/cnUCeHq1kj3x0k07ucJPSJTKWdzb/Hp
         K5lA==
X-Forwarded-Encrypted: i=1; AKwUvBxkQnFa4QNs30rgb4+QOxgUHWkwDJBrexAkUoLxRLMbAB9QEwXEH+XnxWhtvaTzs1IxTBlf6+tInkkRDRY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKruwlN4Z03ErF3cCWFz/wl63hsKziEuAGlGRlfVBElEFioQ7Xs
	GF2ybHkDcmkojD+OsRS4tameZyKVdY2zfiMJvIiAx8hkUeEZ/2VI87XP
X-Gm-Gg: AYBFou0lGv6hWOluI5cXYgMd6OQh6FXZUIa/ueaUtHqbG3QqnBxu4fcoqa6NF/xa486
	AhiAg+ZGNl3ErWk0ZFIIcBdAP5o2NSxLvOPbFpD4fGAkV2LiakZsY6FZxyjsiO366sVbyZ5BQLu
	HUC8XrNRqs5skYeIh1M2dUKe7n1jqVNZaLqNuu7WbeUfwTX1cJG0vBA+klNXId7DMKkqTHJ5v9y
	j8Y0jfhLNVB4pQ4ewNcHBb4FRXfy5z8bfvrQes2gLcmj758xeNybYrcCBd805pmNO89nUCJWsM5
	AWXvPehfI9Evz+KfIwv3LWAuLnjgpC7VCin33nwl0OZeJMOU7qeqtstAYk4kO7Z+s42AolZEeDa
	1hOVPTrTzabTXzM8/5eiyObAzpGzRaa8+lu/KodSFZG0eZpnluQh4Wte4sMkT49TjIKQc0nb7HC
	ylUmhNwH275ssDw8YcUJe3n4G+ZlU7psBcbxJQM6Pjvk3l7V5u4X+C+m0WD0W5cDWoAsuu6X+DJ
	M1zsrdfwY9l73POCaK5YzE5FBEqfQKztbjfAAmc4fzwvRz+gmbfM8Vd1h1Wy5Z/5FQgwhHE73ap
	Z3v+RLWx+UjByoy3EhuWuF+QvrhKV3BuRoekGByaq0F0ZZtLEvaUMjiU0w1ux2s+v8C6YSIYclq
	SxjNhFa5F0/49WQbnvL8YrEJlirA/3beg75VcJZq994NgQP4QDVKoZI0sUSq7ho5TZNW3EjF9Vs
	wxpT6V
X-Received: by 2002:a05:600c:3f07:b0:4a1:813f:2a60 with SMTP id 5b1f17b1804b1-4a35ac91137mr150192625e9.11.1793083971271;
        Mon, 26 Oct 2026 23:52:51 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2ac-9b01-6900-1f92-d182-4435.310.pool.telefonica.de. [2a02:3100:b2ac:9b01:6900:1f92:d182:4435])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2ed5a2sm259282285e9.15.2026.10.26.23.52.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 23:52:50 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Austin Schlegel <schlegelas@outlook.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Alan Cox <alan@linux.intel.com>,
	Stephen Warren <swarren@nvidia.com>,
	Austin Schlegel <austin.schlegel@arthrex.com>,
	linux-serial@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/3] serial: tegra: fix DMA descriptor use-after-free and stale completions
Date: Tue, 27 Oct 2026 07:52:39 +0100
Message-Id: <20261027065239.95915-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261022-serial-tegra-dma-uaf-v3-0-129f6d67f673@outlook.com>
References: <20261022-serial-tegra-dma-uaf-v3-0-129f6d67f673@outlook.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 22, 2026 at 05:10:23PM -0400, Austin Schlegel wrote:
> Patch 2 (TX) fixes the same ordering bug in tegra_uart_stop_tx().
> It also fixes tegra_uart_flush_buffer(), which terminated the TX
> channel without clearing tx_in_progress, so a later
> tegra_uart_stop_tx() acked the freed descriptor.
>
> The bugs fixed by patches 2 and 3 were found in review (Sashiko, on v2)
> and have not been reproduced on hardware.
...
> Testing was done on Tegra234 (Jetson AGX Orin) with GPC DMA only. The
> APB DMA driver (Tegra20-Tegra210) recycles descriptors only after they
> are acked; the series keeps every ack but has not been tested there.

Tested on Jetson Nano (Tegra210, 70006040.serial with tegra20-apb-dma)
in TIOCM_LOOP internal loopback mode on v7.3-rc2 (5b0764a53235):

- Unpatched: queuing a 4096-byte TX DMA transfer at 115200 baud and
  calling tcflush(fd, TCOFLUSH) 5 ms later leaves tup->tx_in_progress
  set to TEGRA_UART_TX_DMA. Subsequent write() calls see
  tup->tx_in_progress != 0 in tegra_uart_start_tx() and never start TX
  (0/48 bytes received on loopback, TIOCSER_TEMT == 0).
- With v3 applied: tcflush(fd, TCOFLUSH) during in-flight TX DMA clears
  tx_in_progress and the follow-up write() transmits (48/48 bytes
  received, TIOCSER_TEMT == 1). Twenty rounds of 3 Mbaud loopback
  transfers with mid-transfer TCOFLUSH and port close/reopen completed
  with no warnings.

Tested-by: Karl Mehltretter <kmehltretter@gmail.com>

Thanks,
Karl
