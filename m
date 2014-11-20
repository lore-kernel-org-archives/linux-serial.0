From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] tty: serial: msm_serial: Don't require DT aliases
Date: Thu, 20 Nov 2014 07:10:35 -0800
Message-ID: <CAMAWPa8m5Ey6ee8tK8n8g7T6XL7=ZfLzrQgbW9-2iPVWnUfigw@mail.gmail.com>
References: <1415990361-8897-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:40167 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578AbaKTPKk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Nov 2014 10:10:40 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 8A564201EF
	for <linux-serial@vger.kernel.org>; Thu, 20 Nov 2014 15:10:39 +0000 (UTC)
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com [209.85.212.174])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 689D320225
	for <linux-serial@vger.kernel.org>; Thu, 20 Nov 2014 15:10:37 +0000 (UTC)
Received: by mail-wi0-f174.google.com with SMTP id h11so9038885wiw.7
        for <linux-serial@vger.kernel.org>; Thu, 20 Nov 2014 07:10:36 -0800 (PST)
In-Reply-To: <1415990361-8897-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Frank Rowand <frowand.list@gmail.com>, linux-serial@vger.kernel.org, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Tyler Baker <tyler.baker@linaro.org>, Kevin Hilman <khilman@kernel.org>

Greg,

On Fri, Nov 14, 2014 at 10:39 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> If there isn't a DT alias then of_alias_get_id() will return
> -ENODEV. This will cause the msm_serial driver to fail probe,
> when we want to keep the previous behavior where we generated a
> dynamic line number at probe time. Restore this behavior by
> generating a dynamic id if the line number is still negative
> after checking for an alias or in the non-DT case looking at the
> .id field of the platform device.
>
> Reported-by: Kevin Hilman <khilman@kernel.org>
> Tested-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Can you add this to tty-next.  Without this, all the ARM/qcom boards
do not boot in linux-next.

Thanks,

Kevin
