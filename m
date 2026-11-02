Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648069;
	b=k5nt4b3v9ZR9pzmk+TWX6mcpzNaaOMDherCxVnJRI8SbeiIStWc5sHfxUgdvvgKen7LY
	 Q3XhY5twqHiQlCrHxhTsaG4GI04aJ8ZbW9jjepi0ck53X8iIHyCZQLoHuHVJuLtu4+vW8
	 mvkJ72O3RN4EuSLgAB7jcCj9Vsvvg+CtoIsAIoUkiMavgVlKZeNfZDvl62xWqzjKHN5g6
	 avj9ObrqXq8b41eycEPsruOtrdPZE7k3NMAIGv16LQK0A8yBm5r86jG4PAec2AgknRkMR
	 Smr67PifdbmWZ4ulpEYbXfkWfAD6A43M8dMwaWp0Q4ITeb1SfBwWthJf8zd+4FQpkww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=E7gBCzFYvmg/wm0ZG+Fa6cYfj054waIZVNwZet2Fyzo=;
	b=rbQ0m9Wjnel/EuJnDPSBoDDDxhexGmDwXAsYIbEf5/FQenX5QAtVozPCPJ5EM+fBdwD5
	 5xX98M8ZTeSeb/jOQpsLN4zIB4Hsd76b0kuZFDQTShY8jh2njhsc/nuPXMmZl4xegrkYd
	 eQrytM8cZQMihVUPDERNWrt0P05kQjA/4g/cE+7BU9iAmxY6Hc03GQx2KzIi/twYIEx7z
	 kHjBwqouRplLcwd8Bx9bOfl1lJni7MTwivk/rmgmG93V+EDfizV2kzdlIYQ4gc3cJPXHI
	 okQmuIJE/udzG9Y0KADTj356PdshoMqJg+8KRY820EkUweSX738orbcDRzSMPMEIPIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxQzlu+B;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0606082BD3
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB0606082BD3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxQzlu+B
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-8256106635eso1644348a34.0
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 11:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648068; x=1794252868; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E7gBCzFYvmg/wm0ZG+Fa6cYfj054waIZVNwZet2Fyzo=;
        b=XxQzlu+BSk1rbUr3fSK3jJwHiSV/vHO2sI9CexZymuWrVQVZFQ5EgJ8lB+oxsZ5mYI
         gF4lxzQn6U4UwVH6JjmVsogo/vmycOgclfKwkcy7lJZ6uvB64287SHnhG/a1mAxBKW8e
         eTjFzmR0CMhp8EtpV7ENV2FNhhlltgGPghxnOcxxQrXs/h+YFYLCljA2Awr/OA7ZxT82
         OcpOFy+Iyv3HB5m41M2hP6xB8cpbWoO0dVTGBE2D5tk/RXRACcgrkbcVZ2Vb8qLQCI5H
         Y+5NnRzZfU028nkHnxKO0pre5/Gq/AovnbqE9i4+F7w1YSKc6Beh+0VKrJWiXNAimo2L
         LHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648068; x=1794252868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E7gBCzFYvmg/wm0ZG+Fa6cYfj054waIZVNwZet2Fyzo=;
        b=iGSpdd8zq+jTvjDjZsuNPw5w5+KLHzHV/cDFwoZkKy2Z85aRt3YIr6H64eX54ipkfI
         NdmxiyKGoDwlZhWw5fQ2sBUiXn0RlSVu9z80tnMwXpXAW5ACHWR1IkPyyBVnOZk2PBZ6
         qfiQFpPNTUpmYRy5NZ+IwSsPVUwy2xbxoyFic4j+2ajyvJ0YwDynNNlzSvhdp5FPb2Pr
         KeNfyTZvaJTWgm+CaIVMNKtP4I4N3LDM8FzOncV6Z4qA/kFhDP/FbuFKWuyANY2xW7+v
         fN9EXTa0M8o5eS/v6avtJKfFhs3vnqtshWXMakO9S0B3WrI8qeEACz/SIWuKN0pOs+7W
         uDOA==
X-Forwarded-Encrypted: i=1; AKwUvBxiiBYxrD/QmF/7ec0cAZLxResohdf1utgZjbCtGH3oCYiUc0i/411Xc1bJ8ODgQCnTCVFuUDeWCALMDgs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSY/9I5oqqyJ+Bpw5SJQh7ZAvZ/ykhaJr0GW40dnI3ay/iatkg
	3Uk0XdwlGnIM7PvK//S1RloCDoor5aWEJsLwB51U+b692VX7CCmvla4+
X-Gm-Gg: AYBFou1IKAsBLxWUIYNy6HDASRix8pBh6T2XerWbYVONVmKuxUnQZ4b3bi8IsaPZqHq
	JuGOg83gSKDMoubk58pKv27qlCtkD6wJEIkTiWtRzuO3A4FoaN23VoP7Emkd9YEwlcGcEkjZHT/
	6nq+BfrmE7U8iYuojarx2FZ00jqS94XPIHhg1xqkjyuhgj6crW6JzC+1B5v95Dv2dmlw/d4NqoW
	Wma3PIZ9l7IREmM1hq9o+AVUpoNuEa5PC/RLt2Xx6MrX0GKc2D8g8EU12zDWn7SuFSqP3vKud1Q
	vT8JBmvilyTHKFcAzxR7EOXkbsKoEyTFP3isbFpHUXo88Mm3s09ynooIsZ7sHKHrPG/57Gx/tdX
	SIXeZU0Ro3Vq0o/DQdAPQswtJXCSn5s+Lrb0MEVkUKL6G1yoHPP3e8ptDIcrf1hHMqPWX7OCJyC
	dKfNZAGzf4U+E60nVBZOaccr/kailBX5ZaffwW6OGeVv8bHcbI4hAdk1kHcBikoqs2hi3dbmF8l
	6XopIOyi/FqVmLxYlFhgj+X2JWS4u3uSFhS366Bw+xiCKKTlmCwm0PLmqJlF96fxLUcfC4wJ632
	ExqHvSM2uoA1Cns6GUxznexGg/NVx7/NZ1TQDe9oIV8spzGnPq85OvV5UbegF5mceSryNdm3aNs
	xLH/Mf95liJZ/md/fDa1cTvVOCup3LoyVGwXUzyIYaz/FkuGBHanFcA1/Pu6qdGmX5AlvGfjvL7
	9FdqGFyWQW2qnd+9P/j1J3mNEfWVDw4xbeF47iWO0Mv9r4PRcHVA0=
X-Received: by 2002:a05:6808:f13:b0:4e4:627a:e094 with SMTP id 5614622812f47-5640dc2c8a7mr7309751b6e.11.1793648067810;
        Mon, 02 Nov 2026 11:34:27 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm8558249b6e.3.2026.11.02.11.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:34:27 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:34:20 -0700
Subject: [PATCH v5 08/10] dmaengine: dw: drain the tasklet before releasing
 channel resources
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-submit-dw-dma-synchronize-v1-v5-8-d3207758fbf9@gmail.com>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Dan Williams <djbw@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2

The controller tasklet invokes callbacks after dropping the channel lock.
Releasing a channel can therefore clear its configuration and disable the
controller while that tasklet run is still using them.

Disable the tasklet before clearing channel resources and re-enable it
after updating the controller's in-use mask. This waits for an executing
run while preserving pending schedules for the other channels. Have a
pending run return before accessing registers when the last channel has
already been released.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 0fd49ff9257f..339ca85952fa 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -393,6 +393,10 @@ static void dw_dma_tasklet(struct tasklet_struct *t)
 	u32 status_err;
 	unsigned int i;
 
+	/* Channel release may have drained a polled completion before this run. */
+	if (!dw->in_use)
+		return;
+
 	status_xfer = dma_readl(dw, RAW.XFER);
 	status_err = dma_readl(dw, RAW.ERROR);
 
@@ -1062,6 +1066,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	struct dw_dma		*dw = to_dw_dma(chan->device);
 	unsigned long		flags;
 
+	tasklet_disable(&dw->tasklet);
+
 	dev_dbg(dmaengine_chan_dev(chan), "%s: descs allocated=%u\n", __func__,
 			dwc->descs_allocated);
 
@@ -1087,6 +1093,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	if (!dw->in_use)
 		do_dw_dma_off(dw);
 
+	tasklet_enable(&dw->tasklet);
+
 	dev_vdbg(dmaengine_chan_dev(chan), "%s: done\n", __func__);
 }
 

-- 
2.53.0

