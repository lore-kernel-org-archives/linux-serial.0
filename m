From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] tty/serial/pl011: don't print error msg if
 dmaengine_pause is not supported
Date: Tue, 19 Apr 2011 02:27:36 +0200
Message-ID: <BANLkTi=rhN1v0t00wUU3KrC5yATbWK9D5Q@mail.gmail.com>
References: <98422bc7c3ebb4bf6a4ab26179b3f3b7d1a5b5ca.1303125086.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59057 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab1DSA1h (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Apr 2011 20:27:37 -0400
Received: by wya21 with SMTP id 21so4395956wya.19
        for <linux-serial@vger.kernel.org>; Mon, 18 Apr 2011 17:27:36 -0700 (PDT)
In-Reply-To: <98422bc7c3ebb4bf6a4ab26179b3f3b7d1a5b5ca.1303125086.git.viresh.kumar@st.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, amit.goel@st.com, armando.visconti@st.com, shiraz.hashim@st.com, viresh.linux@gmail.com, linux-serial@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

2011/4/18 Viresh Kumar <viresh.kumar@st.com>:

> Few dma controller doesn't support dmaengine_pause() and return -ENXIO if
> dmaengine_pause() is called for them. Error messages such as "unable to pause
> DMA transfer" shouldn't be printed for them.

Hm for dw_dma this seems like a piece of cake to simply implement
instead.

I'll send a patch for that instead, can you test it and ACK it if it
works for you?

Yours,
Linus Walleij
