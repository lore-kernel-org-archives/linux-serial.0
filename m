From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: Re: [RFC 2/8] ARM:global_timer: Add ARM global timer support.
Date: Thu, 09 May 2013 15:51:17 +0100
Message-ID: <518BB7E5.4070402@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com> <201305081638.23100.arnd@arndb.de> <518BADBF.4070303@st.com> <201305091651.13896.arnd@arndb.de>
Reply-To: srinivas.kandagatla@st.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:39815 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753143Ab3EIO4r (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 9 May 2013 10:56:47 -0400
In-Reply-To: <201305091651.13896.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Martin <dave.martin@linaro.org>, linux-doc@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, will.deacon@arm.com, Grant Likely <grant.likely@secretlab.ca>, Jiri Slaby <jslaby@suse.cz>, linux@arm.linux.org.uk, Samuel Ortiz <sameo@linux.intel.com>, Nicolas Pitre <nico@linaro.org>, linux-serial@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Stuart Menefy <stuart.menefy@st.com>, Stephen Warren <swarren@nvidia.com>, Dong Aisheng <dong.aisheng@linaro.org>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Rob Landley <rob@landley.net>, Olof Johansson <olof@lixom.net>Maxime Ripard <ma>

On 09/05/13 15:51, Arnd Bergmann wrote:
> It won't.
> 
>> > Looking at the code in clocksource_of_init it just goes through the
>> > of_device_id table, which is not used in case of non-DT.
> All new platforms are DT-only, and none of the old platforms use this
> driver, so it does not matter.
> 
It makes sense, I will remove the header file.
> 	Arnd
> 

