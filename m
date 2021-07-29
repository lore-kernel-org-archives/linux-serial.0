Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67553C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 16:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F10F60F4A
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 16:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhG2QkD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Jul 2021 12:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhG2QkD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Jul 2021 12:40:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3D2060F43;
        Thu, 29 Jul 2021 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627576800;
        bh=066N9zoYxC70xPKHHC7PsWtEF/DGHX1hf91lY6M/Xmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o4pUFYpwxAs+5qG0HE67O7LqFccjeU1VEpQPOxzYrABXt53ai2QP/cIkBpbSVtMy/
         0NWXPYDe3iQQm7Bl7giUpOJKRFCNQI9uoMaPA59+ADqxz6Voij4LipxwhDmjzWWjMt
         qC1l9b2ZUGjWgwj7QD3Zg0zJPboENP0G5OBDl10szs8rgt/i+zam3As4PjBxsrBpvI
         J8C7zKzGUn8kD9ZTevXOVxP9M5i41PNbkJVB9aV9CqnUn1I4c4jclF+vYcEjVYvVne
         nNm3vrGk0ObcYOLi1wNYWAsz0xhK+fntlRGbN7uXK/StPUPOqzwanuX1Kitg37qSFy
         cyMbst5ShhUeA==
From:   Mark Brown <broonie@kernel.org>
To:     gregkh@linuxfoundation.org, Jiri Slaby <jslaby@suse.cz>
Cc:     Mark Brown <broonie@kernel.org>, linux-serial@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/2] cx20442: tty_ldisc_ops::write_wakeup is optional
Date:   Thu, 29 Jul 2021 17:39:45 +0100
Message-Id: <162757633788.53168.6787766542680028320.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210722115141.516-1-jslaby@suse.cz>
References: <20210722115141.516-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 22 Jul 2021 13:51:40 +0200, Jiri Slaby wrote:
> TTY layer does nothing if tty_ldisc_ops::write_wakeup is NULL, so there
> is no need to implement an empty one in cx20442. Drop it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] cx20442: tty_ldisc_ops::write_wakeup is optional
      commit: d7a3a6801913a4b57a7e525c4906d348213acfb0
[2/2] v253_init: eliminate pointer to string
      commit: dfe1114638d1888916fd9ceb50314e19f632dfad

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
