Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744777;
	b=LzezMDicwgtFMlzBn0PHWFwWMRfusFmbzR/RZcFEEJopsFORADqkYCmssasUq+1zC9MP
	 b1EqIytR+OvucysLiHNx4yeq3dUyXG96fJ2RLfNgnKckRPl6636fedfBugyglUTOTWtbx
	 PIlBRuy7UWz/88wueMQsg6tVCpvlkDxDnKDuRbx71LwEpbVBhP9cX13H41geG0Bm5fbvz
	 +ZtWP0PoQ+LUZchwqJwJj+wHhnfzwtTHLe3zqpheUkM8nPMU/5LHA8rhAHEES2KOQYSET
	 I7EmAe2dc7e5KL5peDvSieerGqJT4OsuTMlMQXjSF2JaDKIpIkPVsCYasz7HO/aZOuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=Z27hgKYTb2n1VfMFl375pQz709FIUXDNAK7CWpp6XtM=;
	b=4ww/ilfA2YJWpLhPnMF39d8n3AfZkpKr7EwXKZ8hXPbvCp9mGFmSz5Eb+XCk4l3dDwCy
	 LJfa1tHVHVeRJrT25u1woWji81Ubb4HLmhm7g5DTqz0NVyCoWT1/JpEg3mnw3KwgCW1KV
	 u+Ii4Fj5kqV60CJZ0vb/D0SkeF8341SZ2O3sXvVhb4IalWYKDdisrS/q53egCmdkoW4Sh
	 rmUZ7Enou2hHfXDx5IyPFNo7PT+ZwOJzFkxKc7MFGhM8jXAHTaYEr9UBh59eag/JJ22sq
	 CPLPz31xYOgRYgK/XCJtvsdpXn+Jppv8W4TNtvCJK1/V2lB3xeaYNEI7CPvkT24njGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=um4iDJHl;
	arc=none smtp.remote-ip=209.85.167.179
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEF4606A329
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CEF4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=um4iDJHl
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4a451915d8aso77130b6e.2
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 14:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744776; x=1794349576; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z27hgKYTb2n1VfMFl375pQz709FIUXDNAK7CWpp6XtM=;
        b=um4iDJHlTQS1vMCWE+mHQxM9reo7nYH0ZIojAUj6CCPwE/FUhh8O1xOdfFL/p1yPte
         Cvx5kkQVDbdNhhzYV3cIKoBLsSGOysX+NJFFBCLom2uKAVVSO78/de29jIF0sY27QeIK
         oEtopI3AJoZ97LFszpRZm6sAWFlyOjWBIJJRgQQWZjMWru2OpDHgcyzO/5m+Hd4j76Iz
         oF/wqQhIFCrbPNcqieIqwm4YLsF07Jf1GlKPPA+HDXZL3vGtyvmcY7S8oZFEK08GaUqu
         RwDDGoKB9aHF36nH5bnj7S3EWzJAD4QkmNX3lZGtmvT8rX1dBizFiMo8hB0PdhTa8XdA
         g43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744776; x=1794349576;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z27hgKYTb2n1VfMFl375pQz709FIUXDNAK7CWpp6XtM=;
        b=y2SHrBbJ9Is/P4kjiCB288OAGKbMpehzCYReat7K9KhD1JaG4/OOoOcR0VneVYBeTp
         bcE8NEEvlIoUc9e6Y7iXGkBw42rx1yKGqAYCMS+jd9mLObcpXJFv5RXEUK/GEqIIC0FI
         mWyVWiH0//ZcYi7WamVjL14EfJBkNVmqrmu+OXgWQFVR86l5ulMv7lBauCxZG8dnKbsy
         aBvW1q910xs1I814HjwWSkVqvywPOfuPWYW4dz9U6tufgMXpJMe78PKi7DmABKm/X0fx
         weOYQPp8lh9EMdPhW0IZp/4+wr7d5VJu3g7bhlbdcj78eMjdsIpLkXjOnAlB1ppJC4VK
         XwZQ==
X-Forwarded-Encrypted: i=1; AKwUvByYxMaWhIlxbdfifGemu4++Ud9sK3atkjsXJjRAYsLkXOlc4GjHrl0BgEAih4VqTPIt6cIxzE5eH4HnC0I=@vger.kernel.org
X-Gm-Message-State: APuU4Z96MQmc3XzVG4ejHLkTQG/O2WKwih17+6eRpvOAZ6auA61XqMhL
	MCqTg5mzHQTZVQGgbWB+t16Zrw7vRrV7uxnd3txhJPvjELdI8eYGmsQCQuK6CTmy
X-Gm-Gg: AYBFou2JhQz1+SjBdWvrItDhoZ4ds7epXfDss3nHIuR9wQiMbF/bcSgXBsOaJlBoUT5
	8pQD+Qj3p4Yhaz2evAW2M54S4gs8Zh7tzZJANCJFTYN9HZHCPOy0xmQyx9AmrkRNrz2l91U+UHs
	DV/vANbhPuY78xRu63apNU1iE0q3wtdyIT2DEb0aUwq3LQ3Rj80WELW7ZTEvFuYdrWlxpx/jtS4
	m43HizQ6fXFIgFk5CBJINXngow+ZnDwsHwSyQb8WF/s2iofh0z5DnEzRDDWqbFiNX9PUtyUZ+oY
	SjF0bXseYf/Tp/W06SWcPK20BjHIjpGPhLl30WU7sqZJ8PXzYfAXxxfNhVCn2k3g4yGfasr9swg
	bMW2gb8SuR/XsEiLAYIN/XVPRtsXwZpJhcmAmNt1V8tMWzHdTdWHmu7F/bpEQpafIruBNT3ZN3y
	xxCE0PQy/YzswX0A7R6m3Jx623qTp9m1Rr4JtM0PzdXQffGjVyd3r07EmC5AGMslzo4nGNmGarF
	F96PEsSRffLoMuJWGtJT9SfiW6o9hcdXpWmtcvcbzVlQtQ8WnXc68Tue6J6n3HM88TYdapN/52Q
	lj7/fkzFdPQsYtdA1KS0r+TiS8yAwCd8z+NJ3c6K+93LNKhWCMvDwRlqvChKJ3acLSrIR58WcWr
	5xSufiZP1+uEL1pUsMbBGH3laARi6YsaRPhEHMZGRraHyyxTJhLDRE/1yvkX6cJhcW1QTNKz7l+
	abmitmqCv5moTzJVRAqry1aCPxyLPgTTfJ9OKUpcRIdDr1f8MiUv8=
X-Received: by 2002:a05:6808:1925:b0:4c3:4e34:c69e with SMTP id 5614622812f47-5640d919f60mr12985788b6e.8.1793744776144;
        Tue, 03 Nov 2026 14:26:16 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef58b1sm128435b6e.3.2026.11.03.14.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:26:15 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v6 00/10] dmaengine: dw: serialize completion and
 termination
Date: Tue, 03 Nov 2026 15:26:02 -0700
Message-Id: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43Qz07EIBAG8FfZcBYFCrT15HsYD/wZWoylBmp13
 fTdne4erL3UhMtHZn75MhdSIEco5PF0IRnmWOKYMOi7E3G9SR3Q6DETwYTmTHBaPuwQJ+o/qR8
 MLefk+jym+A105hSUYkHWwXNvCBLvGUL8uvLPL7eM+6/gptVcJ6wpQG02yKxfaELqYoKH2x5O9
 LFMYz5fG858lf5ZBh+n2oRGOeF10O1TN5j4du/GgaxlZrHFxAEmKKNKSAmt9M40bo9VW6w6wCr
 EnBY2MNkE5WCPyS3WHmASsQBGytq3QTRqj6lfDLUDTCHmK8HqWjXBhj83W5blBwTT5+QwAgAA
X-Change-ID: 20261021-submit-dw-dma-synchronize-v1-e550f47fd1da
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

Keep client callbacks in the controller tasklet while preserving polled
completion. Serialize descriptor ownership across completion, error
recovery and termination, and wait for callbacks before a client reuses
its resources.

The series first serializes completion, error recovery and cookie
accounting with termination. Separate patches extract hardware-LLP
residue calculation, calculate it in the status getter, simplify completion
handling and report queued residue. Channel release and
device_synchronize then gain tasklet draining before the final patch
adds deferred notifications and shared completed-descriptor cleanup.

The series adapts Serge Semin's channel-restart and callback fixes [0-2].
Polling continues to advance cookies and software-LLP blocks, while client
notifications run from the controller tasklet. Synchronization preserves
pending tasklet runs from other channels.

Based on dmaengine/fixes at 6628e7d4c6b2.

[0] https://lore.kernel.org/r/20240911184710.4207-1-fancer.lancer@gmail.com
[1] https://lore.kernel.org/r/20240911184710.4207-2-fancer.lancer@gmail.com
[2] https://lore.kernel.org/r/20240911184710.4207-3-fancer.lancer@gmail.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes in v6:
- Keep dwc_get_hard_llp_desc_residue() next to dwc_get_sent() when
  converting it to return residue, following Frank's review.
- Remove inherited RFC notes from the individual patches, retaining
  the revision history in this cover letter.
- Link to v5: https://patch.msgid.link/20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com

Changes in v5:
- Rebase onto dmaengine/fixes at 6628e7d4c6b2, using the shared
  dmaengine_chan_dev() helper for channel logging.
- Split residue handling into a behavior-preserving extraction, status
  calculation, scanner simplification and queued-residue reporting,
  following Frank's review.
- Share completed-descriptor freeing between the tasklet and channel
  release, retaining callbacks for normal completion and suppressing
  them during teardown. Name the helper dwc_free_completed().
- Carry Frank's additional review tags and put the submitter sign-off
  after the review tags.
- Link to v4: https://patch.msgid.link/20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com

Changes in v4:
- Split v3's callback-deferral patch into cookie accounting, residue
  calculation, channel-release draining and callback-deferral patches,
  following Frank's review. The resulting seven-patch series preserves
  v3's final implementation.
- Place device_synchronize before callback deferral so clients can drain
  deferred notifications when the completion list is introduced.
- Carry Frank's Reviewed-by tags on the unchanged channel-completion,
  error-recovery and device_synchronize patches.
- Link to v3: https://patch.msgid.link/20261023-submit-dw-dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com

Changes in v3:
- Order channel-completion and error-recovery locking before callback
  deferral, retaining four patches.
- Require a locked RAW.XFER event before retiring a transfer; zero source
  residue alone cannot establish destination completion.
- Preserve polled completion and software-LLP progress in tx_status(),
  queuing client notifications for the controller tasklet.
- Serialize cookie updates with termination and report queued residue.
- Drain deferred notifications on channel release and let a pending
  tasklet return without MMIO after the last channel is released.
- Adapt Serge's two patches and retain his authorship and revision notes.
  Drop the Tested-by tags that covered their earlier implementations.
- Identify the introduction of the synchronization API in the final
  patch's Fixes tag.
- Link to v2: https://patch.msgid.link/20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com

Changes in v2:
- Carry Serge Semin's two posted fixes before the synchronization change,
  preserving his authorship and revision notes. Add the requested stable
  Cc trailers and Andy Shevchenko's Tested-by tags to those unchanged fixes.
- Add a separate error-recovery fix for stale error status, empty channel
  lists and software-LLP state when terminating or restarting a channel.
- Use tasklet_disable()/tasklet_enable() instead of tasklet_kill() so
  synchronization preserves scheduling requests from other channels.
- Explain descriptor ownership during termination and acknowledge the
  shared-tasklet scheduling race reported by Sashiko.
- Link to v1: https://patch.msgid.link/20261021-submit-dw-dma-synchronize-v1-v1-1-6af85c2d6f69@gmail.com

Revision history from Serge's series:

Link: https://lore.kernel.org/dmaengine/20240802080756.7415-1-fancer.lancer@gmail.com/
Changelog RFC:
- Add a new patch:
  [PATCH 2/2] dmaengine: dw: Fix XFER bit set, but channel not idle error
  fixing the "XFER bit set, but channel not idle" error.
- Instead of just dropping the dwc_scan_descriptors() method invocation
  calculate the residue in the Tx-status getter.

---
James Hilliard (6):
      dmaengine: dw: serialize error recovery with channel termination
      dmaengine: dw: complete cookies before releasing the channel lock
      dmaengine: dw: simplify transfer-complete handling
      dmaengine: dw: report residue for queued transfers
      dmaengine: dw: drain the tasklet before releasing channel resources
      dmaengine: dw: synchronize completion callbacks

Serge Semin (4):
      dmaengine: dw: Fix XFER bit set, but channel not idle error
      dmaengine: dw: extract hardware-LLP residue calculation
      dmaengine: dw: calculate residue in the status getter
      dmaengine: dw: Prevent tx-status calling DMA-desc callback

 drivers/dma/dw/core.c | 287 +++++++++++++++++++++++++-------------------------
 drivers/dma/dw/regs.h |   1 +
 2 files changed, 147 insertions(+), 141 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261021-submit-dw-dma-synchronize-v1-e550f47fd1da

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

