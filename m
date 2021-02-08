Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EE9C433E0
	for <linux-serial@archiver.kernel.org>; Mon,  8 Feb 2021 18:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04B060232
	for <linux-serial@archiver.kernel.org>; Mon,  8 Feb 2021 18:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhBHSSZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Feb 2021 13:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbhBHSRB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Feb 2021 13:17:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AEDC06178C;
        Mon,  8 Feb 2021 10:16:21 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612808179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7LMdKWQRZRSZEvKnpunODFn/eJin4dDOmq6MpkpVoZ4=;
        b=dX9TlRrtQXsDn/N8qFxtBBV7HgJOyaBpTPAtZdE1fVqIyf52qRiGipowfJm0iSqZRAGt1J
        puieYrHSP1kg+D+gKV8o8geZFA5Cxz1KYiy5lCGsyqTba2KumaCApgl23Za91ix6oeMCVm
        UhWsCKr3TQnHeGYj79BKohq3z+etnA2tLp2hyvNFrG1zY7iXHhUwjV6T5Fdcov5Qwv6pjR
        q3o4YyfOOU4XZ7K3/XEGvilCenYyYDSZ7q+k6s+ejx/GuCS8Be9jBOEE+SzRT6TiN1S0ni
        3kaJCOpOCAEx5XImwlg6tRIdVKMJh4Q0vELapyclzZtc6sS73Cm9+uAl+sz6Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612808179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7LMdKWQRZRSZEvKnpunODFn/eJin4dDOmq6MpkpVoZ4=;
        b=o0MZOZhvYfZ0ukvFt/uYVQhE89g9om7WsK4YyE+ZDaf7qjvP/4bhc9yL6EZqemw/c7e8m5
        Ywsz3KrurjP5L+AQ==
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: tty: Remove in_interrupt() usage.
Date:   Mon,  8 Feb 2021 19:16:13 +0100
Message-Id: <20210208181615.381861-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Folks,

a small series removing in_interrupt() usage within the tty layer.

Sebastian

