Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56718C41513
	for <linux-serial@archiver.kernel.org>; Tue,  1 Aug 2023 12:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjHAM0A (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Aug 2023 08:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjHAMZ7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Aug 2023 08:25:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F195F10C7;
        Tue,  1 Aug 2023 05:25:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84FAF6156E;
        Tue,  1 Aug 2023 12:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2EFC433C8;
        Tue,  1 Aug 2023 12:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690892757;
        bh=qDmS5AL4Z6d+/dt55lZBTzRFNXfWkRpgfk73IJyzw2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHiGs5TpDRAfQTKatB3QCQpE8QcBxTbjItfMQk0Ay7WKlmHRFSTv5X5wdhxFpthYj
         oDPF/m4bqRv0xCoSFg5ixO7W7GtAEaMy3v2Pf+/oI11xr0hT04b/rfLz+XeCTn3myU
         Fqio2i16zgTThIEN0BI0MQWeEK7SaBsZs7urM/GqUBQpHCQ9l+ZelAY1drjhoew2Z9
         C6FwyTO+liNvaDeE22bjTJmAtt2uZ2RCrA8c8XP/9nUB1iNW+D+rZpcN7X2HIccroS
         IHumSy5ClpiqEm4SZBR3XzXMOf40609V64D9LFoIbEGIssnn3mTqunn/PaYDgGg6AO
         XSjaCcFg85kYA==
Date:   Tue, 1 Aug 2023 14:25:53 +0200
From:   Simon Horman <horms@kernel.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] can: can327: remove casts from tty->disc_data
Message-ID: <ZMj50QYDsFtf7jT8@kernel.org>
References: <20230801062237.2687-1-jirislaby@kernel.org>
 <20230801062237.2687-2-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801062237.2687-2-jirislaby@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 01, 2023 at 08:22:36AM +0200, Jiri Slaby (SUSE) wrote:
> tty->disc_data is 'void *', so there is no need to cast from that.
> Therefore remove the casts and assign the pointer directly.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

