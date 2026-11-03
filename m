Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744786;
	b=iR/HugPHJcepadpfY7C5P6VMQbTk7RiONQbh0YBvqNiVuP0RHXJfZ8auBF57w/Nrk+/8
	 X7yLOXDrC8avnAnYK9C8W5gYWvSoUo0/loUYdqCwBXJfx6T3eC+TfqLZJFE+LynvKHy0x
	 NtDFyhTyIouEd+3S0d0ZZnA+90IG/QKP7ZaWbfuYbRgkX8s8ptRVKFxOGGKKr3N7D9G7t
	 3ljTCtLfD62UGVqv2edAlwHmozEcrhBx5kPXnIMywHozsD7cVjlHN8LkMZVgE1GBMdtnC
	 c7Q66V7N1J1uqy+X1B+tzzq2bqb14r7IsV2RQpTnn2uPbaUHO4mkp+o3llkhJj9agsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=7xV7K67o452vhJBNNJkVqcceAfykbkpk6Y6a+s1Bbb0=;
	b=XTQLAXqreITAMuh6VsjzeDr4o1PP7QQx1WKiZzfpnUjSikZP7TlRPyuJ2+95WjNSOgei
	 NwTTXblsyfGmNh5OPT38KQeJAc3vdD2SQdfkGqeZAmXPqpvoFMAebbIn0OdsJv0ZtXu13
	 HsbRZE130cgQMZkDZp5j7WoCicbNrqpLbcCkMEiG1s0hLa66FJ+jUwZ1wdlEYU0jtbKnM
	 qteURYm/7ZDXMyrwD9rzpjFCyx2jWsgsKooxOtsCBkJh2DUm3WoWwVFXGWU3/jJBKWtMn
	 ZtCTXoYpG5/rEankEWbWTb6VOW2dGCNsIf/JNA2drp58E1pt3SANIb+Fiwha+I26FSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GhPrm8II;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FA8606EE9E
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10FA8606EE9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GhPrm8II
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-8470d7d430fso17623a34.3
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 14:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744785; x=1794349585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7xV7K67o452vhJBNNJkVqcceAfykbkpk6Y6a+s1Bbb0=;
        b=GhPrm8IIBrtjPnVeqbElAzArzQ1IWq+ouDe7FcEjHnZV2NsRy4MCfOjR5Vz29F+p1C
         iL5Ul3vDwGGwLDRQ6+I7dZD6LaZRCt/2Vynaohts9U+h0pKPumMuQwZsjf8am6/LepD6
         iwPduU1z5CSM41kp33QpRUqd8hijDNbvoa3EudiVfF0ZTYvRkT+PM5qPNSA7ubHT68Yc
         5m97VSgKccvzKqzNZaP1RocVUnbbyPN1tCayy3BV4BukpBra6IFZsUN8Hjv4ijG+MKZ5
         2ZKlbGHmVq8QKoqJQFr4cNTTU3VKq0+LC0PXqxpYAkpWRVgY5voNHGomx2nkiOE6xDvv
         A9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744785; x=1794349585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7xV7K67o452vhJBNNJkVqcceAfykbkpk6Y6a+s1Bbb0=;
        b=gn419V3NybgwJIPXg5BoBQyeUK1v9zG9d5TuhkxM7w5k9r9Dev9+eoefR2mK89t75u
         WjTE27Vm/7w8nfK7JWAAWuVzvQh0Sug4QYVnBVxR0f0F6GHhR+/Ks7VKY3d8BrBFXXeK
         W9lW444onrT2YEBpV7LuNFspQp6HJHnrmKK5Qk7Z90TaUiVApBjafoxCYZlhv0cwiuw/
         /4WJumk5jxRPL0FIMOlWArC4Bn5ZOqBwUHMzNvSCSmjcH/ROb5Kg3lTcVZ9ZQc7EQP1t
         VDOpWhJwArVMUMe14B58mdkgLjgWihqYQmGkDjwj65Saw98t+Y87NL4/zjEAlipuPl0C
         GAwg==
X-Forwarded-Encrypted: i=1; AKwUvBzmdwTjA/3g5Aduid3rHuu43KB78+POMz9gxxnSmhOxpKxSlH7FI9w5b7/r5ava48O/vqpdX3nV4OiGads=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WBCB+3A5jpFjWfevugEceS/SXgeBdyJ2JErPRnr1KEVkzksqn
	TktOq7fT7yEUM0qTLKTl+XXD1jBMMdL7h9eneFNbkxfw3zAFNNwUwbpH
X-Gm-Gg: AYBFou1CnxwL8UDbFrOd4rE6UlLpxfYmmBbtRWXBl7Pgrgd5kRa/vEdbgHS2s95w76H
	UAg/Rfqc9nAUOaK5RBsP5jx1nGvNOCFWLwXxAjE/RYvFsZvntdu4Htz6yU6rWZXi4nIyk6Q9XOq
	r53sr5AD2wFwIE5m8391tpXYKaSPKDm1A2sAuOgupPOBfGw6vRs92w7SITP4YU9SrByQw0CM1UB
	VCndPt/FimrjZtl33InbiV99OsaG2fzMWoj9KXdMkMiPY6yXlZZSdRgyt+/VIb/GkvNad9ztZbx
	P3NYOBnwpHGTTUkkBnAnoQb2wNX0FOkIU76FHf3ebdZvzOYeLZtLGNaNonjKmtRPJWzn8XQ1xMh
	swimhV6KpSbn1WH1SRG9RFSepgT/9CRzcy1etV0AVZaWRkIUj9Tl7xkNyeAoerdRYTih2O86you
	AbjCnzZ4+iZIz4mpLvejZw86I3Gh6SOZK2HUa0Mnt+CPyLYH+29CFmV2TtH6Xbxfv8tlqw7h3xi
	iN4/Q2yYzjxqkMT6ZEmUVY0VFNkVDpRKgY6HjoGuXju20F915Sx6knsiX72w4dMC9jLFPd1MiZP
	EpCWT1Zm4eHjEp09Qxb8pinuzRUjN81jzQ4DV7lLSA3ogLLS98adHetCXLrY3aa5IKB+v89cdfI
	2ofrnJSwUabdy7lPYlbyfZcro6mEAuzDbeNGZOBqll+gBEMGosBkiWVU8reaAWcTUA/iI4P9JpG
	p1BpxOhs50cPL4VcPexB2mRRDS3HgfT3oUA4k0hegST4VU0igBIAo=
X-Received: by 2002:a05:6808:c122:b0:55e:fa63:7001 with SMTP id 5614622812f47-5640ddca9edmr10561090b6e.36.1793744785023;
        Tue, 03 Nov 2026 14:26:25 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef58b1sm128435b6e.3.2026.11.03.14.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:26:24 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 15:26:10 -0700
Subject: [PATCH v6 08/10] dmaengine: dw: drain the tasklet before releasing
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
Message-Id: <20261103-submit-dw-dma-synchronize-v1-v6-8-2ee0c348224d@gmail.com>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
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
index c602ea01cb83..56a422ba14c1 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -419,6 +419,10 @@ static void dw_dma_tasklet(struct tasklet_struct *t)
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

