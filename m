Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C77FC54EE9
	for <linux-serial@archiver.kernel.org>; Wed,  7 Sep 2022 12:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiIGMen (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Sep 2022 08:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIGMem (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Sep 2022 08:34:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF84C19C2E;
        Wed,  7 Sep 2022 05:34:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50827618E3;
        Wed,  7 Sep 2022 12:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD2BC433D7;
        Wed,  7 Sep 2022 12:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662554079;
        bh=kp78ls5gDBiSgaY4vtqVnjMME3JTLeEU62Pax8l5OPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qXpkboMYWI1o/gPCyp/Q8y2t//Bk4AQecmGfn8WNP8PyN7R2vfds7dMZ5mKDTIwlN
         0DPbcVyII44U3cfeOVQN+ufYyLGdnomlMly27x+SBXe3b3Mc9mJ91RJaLWd/O8x4BG
         hEozQSJ9AIXzkqMr7SJ8h06wTGNdPU3jqovHTyjs=
Date:   Wed, 7 Sep 2022 14:34:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiangshan Yi <13667453960@163.com>
Cc:     richard.genoud@gmail.com, jirislaby@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] tty: serial: atmel: fix spelling typo in comment
Message-ID: <YxiP3NfgH+2iIiXy@kroah.com>
References: <20220906063957.2951323-1-13667453960@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906063957.2951323-1-13667453960@163.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 06, 2022 at 02:39:57PM +0800, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix spelling typo in comment.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>

What is "k2ci"?

Please follow the Documentation/process/researcher-guidelines.rst rules
when you use tools like this.

thanks,

greg k-h
