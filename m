Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742011;
	b=0hSbQ9ipj+5pF8lXIN1sQnTKt8mR3aVYrFU6m8tSfFobo0OoyG0bFz6am/aYmE3q4Goe
	 2MjWiJ225j3twcLZ/WRtkn+OkFzxmoMibT2j2qDFLHqyCyIBr0JDesECvZCaeLinIYky1
	 Lw85Kb6EDXxEzQpDFmM7X7xWTtONk8U6o+stjOhjqQ3CQg85WWIySq2P+fBLYNBEw9+iL
	 fcEUgbeEMe5efY6AiMlyL0KYnL9/BFQJj98AulifkP82Nty9Z8U5LbznOsAKtghWLctJ5
	 rXKPaw/NTRj+dQny97AHXsObxOUSo4GwcQEOkGtrcjxcTx1XaVkejXdpVwt1vK3d8Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=9v6fhE64vJST/e4wIKc/qZZ4G1qcfWVja1/2g7y5JFA=;
	b=KEfVu3wPNt3s9BC+t9VQgEVpRfPR4Ul8yoWf7edNVzW2YG6wM56sCbuGuA5qogh8Egjt
	 UaJtKEqwNUde/VZL90d1FCLPVx3IJ8pFyuPIEzcOAeMmmGG41kAA2bAOxnBzjtF4jfhzN
	 Jg/ePrd8ydJPJO6PrkT9uFpE7Px+9/+YHYm+TbSKNS86Pi+Bx7hBypaDJp/aVcouhAeTk
	 DQVrcHuydktt6QiauDT5BF2KtudJdbK13xR+kKK8uClTnL/BhO0Qicw5LAdxs/RewKksd
	 ieiTs1gFSsLQAuLf+eCL/Qv9rrdmt0rF2L6Bn/ZKoCMe/K8B0mjVcd9Cu5gyblyWKyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EEBiMSuH;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEA2606D811
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EEA2606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EEBiMSuH
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-85a5455bd3cso10509a34.3
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 13:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742009; x=1794346809; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9v6fhE64vJST/e4wIKc/qZZ4G1qcfWVja1/2g7y5JFA=;
        b=EEBiMSuHQEQBAiNxmoAZwWAQOzZsZRscDbuJCfiW2amM879KWEAz0qvek7925XV0sI
         bifHFqPkH+Gzs+F2ySuS+DbPYgTBlLMMMUE+1J9KZJio6tJAfRMKMyR44JyO+qrRXrGj
         ft0eVdNEH7HmL9RvhGF7+gX2JT5Kg3v53pVUGwd+MCoaBZ0heCSX/ocbUWxlIMaKpq04
         T7H1R3fqGk/2D3KiJeZb2VJyjJTAC4qEEihuEhryuLwDDNYw7xWfNuinxkFOseJCB1Xj
         0vcc01hYOHp4RapZuK4AgHLxH1oq4UpCm+SQkerNQ2Q9YLtBMrBxhZDoVASIXzYIr8/Q
         raqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742009; x=1794346809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9v6fhE64vJST/e4wIKc/qZZ4G1qcfWVja1/2g7y5JFA=;
        b=Fh4PBxcNZd0on9irHvGA1VCa6xj5phKAF1Pt6Ibjtuj9lrjIpCRbnsNAMkbnbCQ9Ds
         gBxxUt0EW3dVgVYhAJE3iKOeUW3PV6I9S0YdZ95RY9b0iqdhcQnyUidXHldmNMNhBrj8
         Jw/dYpIMHzaakBm5ch21yxMZdDuv62YdOFt/HzWhC5InriSrWVb70TT5NS94qOk4PfRL
         ABTBKN+t3w363m6gefT0jWQywLLBPlG9PGq5Oc+7QqgiJBGiKtxewUZ+FuTm+g1qKcm7
         7OX66NjHbIHtHG/80ErTjx8TeMTUZdUi88HnJ/y1U/6h15PoK0v5kCVjSNSRnEudXhi/
         8vdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwkkPI2/pw2ulat/LddNWAAs0yhtQr7BWUo/jvndgDE0oFcecCXw+fCPbVpUTnnqxw47HG4o7uwMsUWRvU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TsB8sW5+r+ed+Xj+DofU3zMNNz1/i7q8Sc8vfFigdsYAduu26
	pdt3TYcSNjqAA2tRUYMunQtPxiC6ZeOpIWoBjR5t4JzypqnG4RlKxbPwqVySvigQ
X-Gm-Gg: AYBFou1AD7uQMW7nSEx31U71oTavQBS3qv/2llbLIncQ+qt9iTT6ZrQpnbzo++egkwm
	b2tVPdT7kSnuO1D0TGuD6252leimHB22TgsreYIddfU8xTnHa5tPzhd2BkXOR7GZY8PKrzByFSw
	txrwWGQsWWqTpVs2P1SrNo+cViI17j8pPEimlJkNt+imC5NenD7yro8yj4oofQGy85h/PZx1sJB
	o1WG3DL0s2MnIld3zVUIE/xpoBdKRBlW8bYmsBFpdkuhDaWyhaemlbB77JdV7lLBc6QLBpa3ltT
	faE2he+YQG1LEF3Y9Ne3v/4+KhRIPeRFDMDC0bPecfwcrTZCyMxvM8DoK+jYoNRi1Zj/w5PKA4R
	D0PAuKR2ot19cPji1rEGtA8Gbav7U1HZnOyGzYIMM5/Pdlo7iEszMeNWdjkVGaWIpt+eHT2lfdE
	3sj9WF7mX0Hfy+aiYbxTeqIxnh8xgaa8VV4E8KqMDAGxq3WYA7cmgLJXVr2ezN1jcjpitJ7Y3Dl
	iXdyQ2JiCmOYaLBj3KpMvO2KzQOMi2+LnHvxB4wXldyRtK4lNtEFUor627HPjZS9evl3fJ+kmaZ
	+1e+dXZjR91SDc3fQr9TRA9spPbANxSVD4zZ1+5zU9PsaxqY1/EmCkKuaXkGTuk1VSJvwl9cOTB
	4ZdqYVJFzgSglGib1M9RdRMkjo/xdDnJtu+ykOP0cbkJnfy1M6E1hbjTeTB1y2vmzQdJpw4Za7b
	6FSxrLGDVIzk6J/AHjwV73Wgn0qR9kT+wspA9q22yn0AVzsAmsZWDDog==
X-Received: by 2002:a05:6808:1715:b0:55c:836:5950 with SMTP id 5614622812f47-5640de0af62mr9879107b6e.27.1793742009246;
        Tue, 03 Nov 2026 13:40:09 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f9115csm27060b6e.11.2026.11.03.13.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:40:08 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 14:39:57 -0700
Subject: [PATCH v7 04/12] serial: 8250: expose RX trigger controls for
 custom callbacks
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
Message-Id: <20261103-submit-h616-uart-fifo-v1-v7-4-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The rx_trig_bytes attribute dispatches to a port's get_rxtrig and
set_rxtrig callbacks when present, but the attribute group is registered
only when the port type has a static receive-trigger table.

Allow a port that supplies both callbacks to expose the attribute without
a static table. This lets integrations such as Octeon provide their
FIFO-relative thresholds through callbacks while retaining their existing
port type. Require both callbacks because the attribute is read/write;
ports with a static table continue to use the existing fallback handlers.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 73bc9e7ab703..d87e2b852c3c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3152,7 +3152,8 @@ static void register_dev_spec_attr_grp(struct uart_8250_port *up)
 {
 	const struct serial8250_config *conf_type = &uart_config[up->port.type];
 
-	if (conf_type->rxtrig_bytes[0])
+	if (conf_type->rxtrig_bytes[0] ||
+	    (up->port.get_rxtrig && up->port.set_rxtrig))
 		up->port.attr_group = &serial8250_dev_attr_group;
 }
 

-- 
2.53.0

