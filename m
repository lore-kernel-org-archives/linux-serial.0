Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695173;
	b=T8TZeV6SVZcgzKga1OYUG5qWXsw0ovM3pjlnkd1kWl5GG2YuC3CadyH5LOi7drZVXpZD
	 SWeEIpdLr9Gej1ZuG2DHHt6FvB7l+bHgrr+96CzL9vfxX63g0uDCeh538m5KTR5K6MbsY
	 EzSeou0RTMS5Jtk7nRaEXMN+PnnCjXMDL+UnNrO7ia6YvG1L6/NJMjJB/G7DPjgygU/5D
	 cWXaGLtU2yr1K7UMm2gGzjiVs3vRw4n71rLmDrFrTlIYxO3O1nyjhmk352Pon1kLCSkW8
	 Cvs4PXbaW/eTRXEMi/i2OsU5MkZd84AWxih9E/Rq2K2oRBF8dVPb1BYkN/6ZA9R0UqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=GZ1nteAFCdgv3lYv5GTFqau33ZwZlxkMbmplQuAk198=;
	b=GMYrnCGmvtD/UEvwO8DPacpc0EkDpII6Wl+1OX+CcjzD/+6yvwUfCRL9A/hH30uznStP
	 1qb+KT6xDm0Top3bIhaWBaoBngORmnX2WZFlfQwBhmDRzcVqxJI8KkoGnUJTRgphZvob7
	 QdbUKHiFtkAaaqgicaSDhbBtb2UDO82Lk+wU3aYIWx2vCfaTSHtKzY3OIujcBLbtnJDqy
	 VoaKpd4P3rnOF353HsDRAzv9/0P6VA2/B//EZbxbnaGBZHeXrUDBHQ6Mrcq0QXSOm3Lxl
	 QnUkUevL7Z3e95axBnF7m7Az7aU+VPAsvW+KrK6d9nOcuNnrT5ZqpcPnCXiHl7p1oPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FTxSiVjf;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C9B606A325
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 18:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94C9B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FTxSiVjf
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-84e513877a3so57253a34.0
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 11:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792695171; x=1793299971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GZ1nteAFCdgv3lYv5GTFqau33ZwZlxkMbmplQuAk198=;
        b=FTxSiVjfZ0qq2ZUPKlU/pcIySGqpVjllv/lO4gD7mPHQsXi448iJsHekK1+EvLr9v3
         oi6nrBvxzwz7Iul2pw/lmeWw5614/bkJnmN+Ni4pmxQvQeQDEga1hXJce8LJEXWuQnSs
         ig1UYmWzPgrTNAOsxeNdbWGlaTK1/yeYf8U7lVBLKRFqSOxPHingByz6Fpv70EDG+dzL
         jQjKAKDdPOMtVlEuHBMQcxn3dX3bguiUBgypSzTcrT+FR3jVWA4SyipWmFXlD8DktEFh
         XyO8WR27uLUDLP7BogVqnVfufw8prS1OdP7wOgwaBF+eiGtp0OZBSz43nF7Mppckd7Rh
         /6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792695171; x=1793299971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GZ1nteAFCdgv3lYv5GTFqau33ZwZlxkMbmplQuAk198=;
        b=nzen7jyae4G4n6UwR02MflVI+NvMCgWAcdaFhcVQYvS+UMNtb7cGDMEDWqR97IFDa8
         RZ11zttxxlb9xBvCHYQsvRxSVT0ukAYRk8rLgxvMRMGIIybAiINbU4h1qkRK+ulAGpSh
         NDjG9CQbSddTIJA6MUx+/Qd+nB+CDIw1GvvINhhHsZDOJyh1D/S1H6W1jSc2rBooGSLy
         oYJ2tPW7oA+uO+ULa2f6Zy1sDT7kzTu84KOcZnvP+M8D4cFBD5EsQZ7ar37xhtTgG3NV
         LoGCHKGR5puvxUfvSe4D9aEiGpUlYJacCtVkZGi7Yczpaa4hb5LVoy1zMIN5E8nkg8UE
         x+TQ==
X-Forwarded-Encrypted: i=1; AKwUvByzdgkE3TT1r2t6EELL2x2wZD/+N2x/qkpQ0Maqt7n45AXlqJUW2b4e3RY6yQVoUCMUieYQNb9I3sQOBnY=@vger.kernel.org
X-Gm-Message-State: AFq9FYITkPw6VvhuGRuuUaF/Pm4a5vZ7+NgkFDtAxLUOG6GtmYkiQHmN
	lGrL5LdE/QN3vr98Brj+oS/upJU9DT2+a59z+9fEXURAfYBbZpvSnrRk
X-Gm-Gg: AYBFou2ab0yMQzVJ3uKV5/2cbxIHg+6hvXhPhvogkP0fke/F1iZ/dz1fjJKtzv/7sqv
	10N9Jpo7pcOn/mrh1u47rrVcyame+KIVKakIGgGE9IpJjLaYHVYDIXZ8uIa+20RUicKAnL7eg//
	wStbOq0WAD0lpEtNHs9BOF1EH9PXowxFZjI/AN0mFfk+tT3H32H+Aw9CBk2I+jBzdqBGgsR9YNg
	YhaaDY852/KF/6CZuLmbXKLLYp9B4DpFwahlQKVsuWp8HE3/LR48xpTLAkV3KdJDrEYge76LW2S
	JahE2kLL1r5CbFkjH18+RmqzKFUIttYPJvNkPiYPCRAKz6lgCJFFIHQVo5kINF5RarLLA/qeRyl
	TRNqGfNLQCYcLZiqo0HSDb0EOmr1hbv2IlzCdr60uCAy+J9FGvfHGcp92rcfEOY4i21wAIquDdZ
	ie93Pm8/0si/sxSjjsPZVspan2mABVAIsHMuHzqARc3jtAYEj4N4R1OdOxIViiRWsPAFVdH0uKg
	MEKrdqqzxtwzSgLRJwzqrecur/qevESy+PxRyWJcPj5Vc3wsR+wQtAN3/qHEIjBN3zEPQTz6Flx
	9+w0ymb2nQwbxnPGmxY09jcDqIxBs8m3Ih1WS9nr97mdCH9xeoyYS1opIDFb52haRCOg1IRSu9u
	67BATCrgugzqLyAZUDwOQpwHnhb44Hi5bF/833XQKAP89SFChUwevfmCkr6qB6eS+wy/am8Z3JP
	z7PVCWnZ1Y22agy14UjxnG7PSo
X-Received: by 2002:a05:6830:44a6:b0:829:f7c6:72a5 with SMTP id 46e09a7af769-84e3162c709mr1835006a34.16.1792695171400;
        Thu, 22 Oct 2026 11:52:51 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84f7703d288sm536083a34.4.2026.10.22.11.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:52:51 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 12:52:48 -0600
Subject: [PATCH v2 1/4] dmaengine: dw: Prevent tx-status calling DMA-desc
 callback
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
Message-Id: <20261022-submit-dw-dma-synchronize-v1-v2-1-5244e94dca8c@gmail.com>
References: <20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com>
In-Reply-To: <20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

From: Serge Semin <fancer.lancer@gmail.com>

The dmaengine_tx_status() method implemented in the DW DMAC driver is
responsible for not just DMA-transfer status getting, but may also cause
the transfer finalization with the Tx-descriptors callback invocation.
This makes the simple DMA-transfer status getting being much more complex
than it seems with a wider room for possible bugs.

In particular a deadlock has been discovered in the DW 8250 UART device
driver interacting with the DW DMA controller channels. Here is the
call-trace causing the deadlock:

serial8250_handle_irq()
  uart_port_lock_irqsave(port); ----------------------+
  handle_rx_dma()                                     |
    serial8250_rx_dma_flush()                         |
      __dma_rx_complete()                             |
        dmaengine_tx_status()                         |
          dwc_scan_descriptors()                      |
            dwc_complete_all()                        |
              dwc_descriptor_complete()               |
                dmaengine_desc_callback_invoke()      |
                  cb->callback(cb->callback_param);   |
                  ||                                  |
                  dma_rx_complete();                  |
                    uart_port_lock_irqsave(port); ----+ <- Deadlock!

So in case if the DMA-engine finished working at some point before the
serial8250_rx_dma_flush() invocation and the respective tasklet hasn't
been executed yet to finalize the DMA transfer, then calling the
dmaengine_tx_status() will cause the DMA-descriptors status update and the
Tx-descriptor callback invocation.

Generalizing the case up: if the dmaengine_tx_status() method callee and
the Tx-descriptor callback refer to the related critical section, then
calling dmaengine_tx_status() from the Tx-descriptor callback will
inevitably cause a deadlock around the guarding lock as it happens in the
Serial 8250 DMA implementation above. (Note the deadlock doesn't happen
very often, but can be eventually discovered if the being received data
size is greater than the Rx DMA-buffer size defined in the 8250_dma.c
driver. In my case reducing the Rx DMA-buffer size increased the deadlock
probability.)

Alas there is no obvious way to prevent the deadlock by fixing the
8250-port drivers because the UART-port lock must be held for the entire
port IRQ handling procedure. Thus the best way to fix the discovered
problem (and prevent similar ones in the drivers using the DW DMAC device
channels) is to simplify the DMA-transfer status getter by removing the
Tx-descriptors state update from there and making the function to serve
just one purpose - calculate the DMA-transfer residue and return the
transfer status. The DMA-transfer status update will be performed in the
bottom-half procedure only.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---

Changelog RFC:
- Instead of just dropping the dwc_scan_descriptors() method invocation
  calculate the residue in the Tx-status getter.
---
 drivers/dma/dw/core.c | 90 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 40 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index dd75f97a33b3..af1871646eb9 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -39,6 +39,8 @@
 	BIT(DMA_SLAVE_BUSWIDTH_2_BYTES)		| \
 	BIT(DMA_SLAVE_BUSWIDTH_4_BYTES)
 
+static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc);
+
 /*----------------------------------------------------------------------*/
 
 static struct device *chan2dev(struct dma_chan *chan)
@@ -297,14 +299,12 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 
 static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
-	dma_addr_t llp;
 	struct dw_desc *desc, *_desc;
 	struct dw_desc *child;
 	u32 status_xfer;
 	unsigned long flags;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	llp = channel_readl(dwc, LLP);
 	status_xfer = dma_readl(dw, RAW.XFER);
 
 	if (status_xfer & dwc->mask) {
@@ -358,41 +358,16 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 		return;
 	}
 
-	dev_vdbg(chan2dev(&dwc->chan), "%s: llp=%pad\n", __func__, &llp);
+	dev_vdbg(chan2dev(&dwc->chan), "%s: hard LLP mode\n", __func__);
 
 	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
-		/* Initial residue value */
-		desc->residue = desc->total_len;
-
-		/* Check first descriptors addr */
-		if (desc->txd.phys == DWC_LLP_LOC(llp)) {
-			spin_unlock_irqrestore(&dwc->lock, flags);
-			return;
-		}
-
-		/* Check first descriptors llp */
-		if (lli_read(desc, llp) == llp) {
-			/* This one is currently in progress */
-			desc->residue -= dwc_get_sent(dwc);
+		desc->residue = dwc_get_hard_llp_desc_residue(dwc, desc);
+		if (desc->residue) {
 			spin_unlock_irqrestore(&dwc->lock, flags);
 			return;
 		}
 
-		desc->residue -= desc->len;
-		list_for_each_entry(child, &desc->tx_list, desc_node) {
-			if (lli_read(child, llp) == llp) {
-				/* Currently in progress */
-				desc->residue -= dwc_get_sent(dwc);
-				spin_unlock_irqrestore(&dwc->lock, flags);
-				return;
-			}
-			desc->residue -= child->len;
-		}
-
-		/*
-		 * No descriptors so far seem to be in progress, i.e.
-		 * this one must be done.
-		 */
+		/* No data left to be send. Finalize the transfer then */
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		dwc_descriptor_complete(dwc, desc, true);
 		spin_lock_irqsave(&dwc->lock, flags);
@@ -976,6 +951,45 @@ static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 	return NULL;
 }
 
+static u32 dwc_get_soft_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc)
+{
+	u32 residue = desc->residue;
+
+	if (residue)
+		residue -= dwc_get_sent(dwc);
+
+	return residue;
+}
+
+static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc)
+{
+	u32 residue = desc->total_len;
+	struct dw_desc *child;
+	dma_addr_t llp;
+
+	llp = channel_readl(dwc, LLP);
+
+	/* Check first descriptor for been pending to be fetched by DMAC */
+	if (desc->txd.phys == DWC_LLP_LOC(llp))
+		return residue;
+
+	/* Check first descriptor LLP to see if it's currently in-progress */
+	if (lli_read(desc, llp) == llp)
+		return residue - dwc_get_sent(dwc);
+
+	/* Check subordinate LLPs to find the currently in-progress desc */
+	residue -= desc->len;
+	list_for_each_entry(child, &desc->tx_list, desc_node) {
+		if (lli_read(child, llp) == llp)
+			return residue - dwc_get_sent(dwc);
+
+		residue -= child->len;
+	}
+
+	/* Shall return zero if no in-progress desc found */
+	return residue;
+}
+
 static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cookie,
 				      enum dma_status *status)
 {
@@ -988,9 +1002,11 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
 	desc = dwc_find_desc(dwc, cookie);
 	if (desc) {
 		if (desc == dwc_first_active(dwc)) {
-			residue = desc->residue;
-			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags) && residue)
-				residue -= dwc_get_sent(dwc);
+			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags))
+				residue = dwc_get_soft_llp_desc_residue(dwc, desc);
+			else
+				residue = dwc_get_hard_llp_desc_residue(dwc, desc);
+
 			if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags))
 				*status = DMA_PAUSED;
 		} else {
@@ -1012,12 +1028,6 @@ dwc_tx_status(struct dma_chan *chan,
 	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
 	enum dma_status		ret;
 
-	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_COMPLETE)
-		return ret;
-
-	dwc_scan_descriptors(to_dw_dma(chan->device), dwc);
-
 	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret == DMA_COMPLETE)
 		return ret;

-- 
2.53.0

