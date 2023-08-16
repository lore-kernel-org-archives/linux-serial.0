Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF07FC04A6A
	for <linux-serial@archiver.kernel.org>; Wed, 16 Aug 2023 06:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241985AbjHPGDw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Aug 2023 02:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241845AbjHPGDW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Aug 2023 02:03:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A941984;
        Tue, 15 Aug 2023 23:03:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEF2062283;
        Wed, 16 Aug 2023 06:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04042C433C7;
        Wed, 16 Aug 2023 06:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692165800;
        bh=/aCuxjKPUr1hg/UXwJjnZLgr4sRzLwAyEL9nKbFrhcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=voomlu7HaBbwXj9DZ+u+Vs/LkpZV8d1+r5r5fXRnWvdjQluKDd5wwThwS7j3uY+VN
         WhVb4ruXC6aVwP7HAo2/27ZNGOcN3Qf3lKsyAWkajYms9W6AMZYP+VtYs6ORAvjmZw
         1TUSuMewO8t4N+Fk4veJrvycjxGcrFg1My3/4h7I=
Date:   Wed, 16 Aug 2023 08:03:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 09/10] tty: n_gsm: expose configuration and statistics
 via proc fs
Message-ID: <2023081644-stiffness-division-215b@gregkh>
References: <20230517155704.5701-1-daniel.starke@siemens.com>
 <20230517155704.5701-9-daniel.starke@siemens.com>
 <2023053053-cider-canopy-36ae@gregkh>
 <DB9PR10MB588118BBA6BEDC06EEF6FC75E015A@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB588118BBA6BEDC06EEF6FC75E015A@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 16, 2023 at 04:51:06AM +0000, Starke, Daniel wrote:
> > Please no, procfs is NOT for driver/device statistics like this, that's
> > what sysfs is for if you really need/want it.
> > 
> > What userspace tool is going to read/parse this thing?  Where does it
> > live?
> > 
> > And what about the security issues involved with all of this new data
> > that you are now exposing to all users?  Has it been audited to verify
> > that it is safe to do so?
> 
> Thank you for the feedback and patience. I understand your concerns.
> Therefore, please proceed with this patch series by excluding this
> patch #9. Please let me know if you need me to resend the patch series.

You have to resend them, they are long gone from my review queue, and
picking out an individual patch to not apply is difficult with our
existing tools as that is not a normal workflow.

thanks,

greg k-h
