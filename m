Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C8CC4332F
	for <linux-serial@archiver.kernel.org>; Sun, 16 Oct 2022 20:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiJPUsm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 16 Oct 2022 16:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJPUsi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 16 Oct 2022 16:48:38 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A62F2AE32
        for <linux-serial@vger.kernel.org>; Sun, 16 Oct 2022 13:48:38 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a13so13523398edj.0
        for <linux-serial@vger.kernel.org>; Sun, 16 Oct 2022 13:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bhE2uLoEWMKBIV00QYWrd1tXeltihTMqmXbCvTgLTbE=;
        b=bjaI9eBskkj9NsQHJoR2zD2OpneSjwarcVCqgeyz0IBTxvQqHh9PQiIEJB4qW7ID2V
         mFjheBNGcrxLmjHR420tOuqpTC2u3WumLbwoDsNhy+aF5ah+BFvJsviQZC9O28taF2Zb
         Vknwp/CDV927QjcOlchu2UuIuwE50ubKEp6wJqA01ZU1Al9PqO3Uwhs2riak+jBQr/tx
         xMYghTJLFEPdnVWaui92NwZ39qvosW0iNiyacExEC/AywbkSwcwRaFxTe5qATftMgxF7
         ERYjH9WPXGwmDOiIhSPUIF66trylPTXSiTUE0gN5j7uEZv1R8YGQpl3KliMupeJcx0O0
         zjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bhE2uLoEWMKBIV00QYWrd1tXeltihTMqmXbCvTgLTbE=;
        b=W51tacIEWqBQNbwexXSW1Sc7+vp0XzSVyt6xCDKUzEerK3sQ0to2GQ6noC9GS5FaSG
         0eEpe9pAiVlV/oq4akWND99/50mbUspuzxT0Fxd1ZvptoU+boUQDbJHWJr9SaIgxBBNn
         8Vb+zmSNDdQEaW6cqOgFP9z+aLi8EXU43mHubTSZ7ZLwmQGxWUTy7fUGCr+ynH4phY79
         Kb16cKpFtHS3fZdQ2zgruBtZxsCFUG5HXnpFcNlRxLckQpLTTXHtbl9CpJKa2LjCkQUm
         xFKakxCWz003GYKqC4/701uAkiXQwhNsBkKf/GtGt+4viEyxIyoVKSJuUEKVqFDz0Y3x
         iqpw==
X-Gm-Message-State: ACrzQf2ys9Q1ktT+6eUe87uJ5T3dmFpVgnKa/odJmjiOOUiUM9VAZnsF
        6JP3prnb883jZkry70bOD7us/khJ2Mjzi2zYjEANViOCg1y2AA==
X-Google-Smtp-Source: AMsMyM4Se2YP9CAJceXJABfEBDqAzLotNYAPgLJIg4MiDE+oP+kwAOxEcdtUY9q34j7uwaUOWifAakuaB+JCVTJFC1g=
X-Received: by 2002:aa7:df04:0:b0:45b:cb0d:856a with SMTP id
 c4-20020aa7df04000000b0045bcb0d856amr7636607edy.180.1665953316353; Sun, 16
 Oct 2022 13:48:36 -0700 (PDT)
MIME-Version: 1.0
From:   Mike Burnett <mike.burnett.texan@gmail.com>
Date:   Sun, 16 Oct 2022 15:48:25 -0500
Message-ID: <CAEeC2hSjvS0dqdBopS5-ebiDObYta5k4zFtiazfh9uyNRnTuWA@mail.gmail.com>
Subject: Requested Information
To:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following information was requested:

MosChip Semi is the manufacturer.

9:00.0 Communication controller: MosChip Semiconductor Technology Ltd.
PCI 9835 Multi-I/O Controller (rev 01)
Subsystem: Broadcom / LSI PCI 9835 Multi-I/O Controller
Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin A routed to IRQ 17
Region 0: I/O ports at d0d0 [size=8]
Region 1: I/O ports at d0c0 [size=8]
Region 2: I/O ports at d0b0 [size=8]
Region 3: I/O ports at d0a0 [size=8]
Region 4: I/O ports at d090 [size=8]
Region 5: I/O ports at d080 [size=16]
Kernel modules: parport_serial

and when booting the network card does not initialize. Must boot to
windows before linux:

65:00.0 Network controller: Intel Corporation Wi-Fi 6
AX210/AX211/AX411 160MHz (rev 1a)
Subsystem: Intel Corporation Wi-Fi 6 AX210 160MHz
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 32 bytes
Interrupt: pin A routed to IRQ 17
Region 0: Memory at ef100000 (64-bit, non-prefetchable) [size=16K]
Capabilities: <access denied>
Kernel driver in use: iwlwifi
Kernel modules: iwlwifi

Thx,
Mike
