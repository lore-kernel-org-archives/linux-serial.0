Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBFFC10F1B
	for <linux-serial@archiver.kernel.org>; Tue, 27 Dec 2022 08:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiL0Ip7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 27 Dec 2022 03:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiL0Ip6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 27 Dec 2022 03:45:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5B7E32
        for <linux-serial@vger.kernel.org>; Tue, 27 Dec 2022 00:45:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4902BB80E49
        for <linux-serial@vger.kernel.org>; Tue, 27 Dec 2022 08:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55B2C433D2;
        Tue, 27 Dec 2022 08:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672130753;
        bh=1B2daThNjcF+5GxupMI1EJiokGetNB5AmkrvfFlosAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lfvkymmpUnS8yFA3fi0F7ARi24KAukT5b4jOMAe/u+ILzQT6Xo/keJpwWkdmbUMhv
         ZXUOKSCTLCzhpnNQeTIOmWqk+OCDpCBmXxYdnxOKFiZB2G86WJ+iwGWw8Ftt7DCsNT
         njMR8mN/XNZRZplEbH6WdPUXFsY3vfIuj/G4KRldoiY2JdeQ4HAX0iBa25xuGwAcv5
         KzU8EMfmidvgsbn0uvyzDYv8gtGOP4oUMtDJWL3vtZsbT6V41jEDGFGfQF60X1oGD5
         aXmYNGidH5AbZiG5m4hYv2XI4s0s89R6+eNnVe6SEdDbOF5LA7O1N3W4nhQJsWnKv8
         ah+1On/gyTyuw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pA5aq-0003Gw-CB; Tue, 27 Dec 2022 09:45:53 +0100
Date:   Tue, 27 Dec 2022 09:45:52 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Christina Quast <contact@christina-quast.de>
Cc:     linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        gregkh@linuxfoundation.org, daniel.beer@igorinstitute.com
Subject: Re: [PATCH tty-next v2 3/3] hid-ft260: Change u8 to __u8 for hw
 facing structs
Message-ID: <Y6qwwHbjmpn/hvp7@hovoldconsulting.com>
References: <20221226171549.73645-1-contact@christina-quast.de>
 <20221226171549.73645-4-contact@christina-quast.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221226171549.73645-4-contact@christina-quast.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Dec 26, 2022 at 06:15:49PM +0100, Christina Quast wrote:
> Structures that come from a device should use __u8 instead of u8
> for their elements. Therefore change all elements in the HID report
> structs from u8 to __u8.

No, this is not correct. You only need to use __u8 in header files that
are shared with user space.

Johan
