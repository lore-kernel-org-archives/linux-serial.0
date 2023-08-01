Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F04DC04FDF
	for <linux-serial@archiver.kernel.org>; Tue,  1 Aug 2023 06:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjHAGXE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Aug 2023 02:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjHAGWo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Aug 2023 02:22:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A031738;
        Mon, 31 Jul 2023 23:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B449D61480;
        Tue,  1 Aug 2023 06:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7428C433C8;
        Tue,  1 Aug 2023 06:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690870962;
        bh=yUuXLOElFeat+t6CBHvNZpwHXCKJGppnz0P+UGVyC/Q=;
        h=From:To:Cc:Subject:Date:From;
        b=ryVMS3k1IHHGSmiWZJNtQ8SkC6aW32Ejf4B9puvFoolOelmhitqRC42aDo5UfHgsg
         sOIpd2g6fPBI7JtjgqaLt8LfTTry/gT/ibCdnS8E9exLbqS2NgJ0/pUB3kB7skYm5l
         uO9iwH+tFw9Z1Fli8+4P/DsCR0bYNk7gr8edxnX5ciIUdlMF9AX8BukHmjlByN5VFu
         vS7ct2GVfraxVEQhICcWszZFt8wbwoeB7VEDiVzwAFgmvNiKSMImdZJ0i7Z/Ds98YS
         3MakD9qmmYBh+9XMbLnTWAmb7dcdmLGuwzM0bWRXT03g+U6BfKzT3ENL5g8CKcqa+u
         AM1Wc0jZ6myNg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 0/2] tty: remove casts from tty->disc_data
Date:   Tue,  1 Aug 2023 08:22:35 +0200
Message-ID: <20230801062237.2687-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There are still two "casters" remaining. Fix them.

Jiri Slaby (SUSE) (2):
  can: can327: remove casts from tty->disc_data
  net: nfc: remove casts from tty->disc_data

 drivers/net/can/can327.c | 8 ++++----
 net/nfc/nci/uart.c       | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.41.0

