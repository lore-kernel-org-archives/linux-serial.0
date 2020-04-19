Return-Path: <SRS0=g+Oc=6D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED82C3A5A9
	for <linux-serial@archiver.kernel.org>; Sun, 19 Apr 2020 20:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673A42075E
	for <linux-serial@archiver.kernel.org>; Sun, 19 Apr 2020 20:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgDSUTe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 19 Apr 2020 16:19:34 -0400
Received: from v6.sk ([167.172.42.174]:45474 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgDSUTd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 19 Apr 2020 16:19:33 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 255E0610CE;
        Sun, 19 Apr 2020 20:19:02 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] dt-bindings: serial: Convert 8250 to json-schema
Date:   Sun, 19 Apr 2020 22:17:14 +0200
Message-Id: <20200419201716.679090-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

please consider queueing this pair of patches for 5.8.

It's a second spin of what's left of the patch set that converts 8250.txt
to JSON schema to improve validation coverage: the patch that does the
conversion preceded by one that folds the Marvell PXA serial port into
the 8250 binding.

Thank you
Lubo


