From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: Re: [RFC 7/8] ARM:stih41x: Add B2000 board support
Date: Wed, 08 May 2013 18:04:41 +0100
Message-ID: <518A85A9.104@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com> <1368022329-2424-1-git-send-email-srinivas.kandagatla@st.com> <201305081820.23968.arnd@arndb.de>
Reply-To: srinivas.kandagatla@st.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:53224 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751997Ab3EHRJv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 May 2013 13:09:51 -0400
In-Reply-To: <201305081820.23968.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux@arm.linux.org.uk, olof@lixom.net, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Samuel Ortiz <sameo@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Stuart Menefy <stuart.menefy@st.com>, Shawn Guo <shawn.guo@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Stephen Warren <swarren@nvidia.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Nicolas Pitre <nico@linaro.org>, Will Deacon <will.deacon@arm.com>, Dave Martin <dave.martin@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <dong.aisheng@linaro.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.orgl

On 08/05/13 17:20, Arnd Bergmann wrote:
> On Wednesday 08 May 2013, Srinivas KANDAGATLA wrote:
>> diff --git a/arch/arm/mach-stih41x/board-dt.c b/arch/arm/mach-stih41x/board-dt.c
>> index 8005f71..1f23aca 100644
>> --- a/arch/arm/mach-stih41x/board-dt.c
>> +++ b/arch/arm/mach-stih41x/board-dt.c
>> @@ -63,6 +63,8 @@ void __init stih41x_dt_init(void)
>>  }
>>  
>>  static const char *stih41x_dt_match[] __initdata = {
>> +       "st,stih415-b2000",
>> +       "st,stih416-b2000",
>>         NULL
>>  };
> I probably wouldn't bother listing all the boards here. Just make sure
> the .dts file lists both the name of the board and of the soc in
> its compatible property, and list all the SoCs here that you can boot on.
I like that approach. Will change in the next version.
>
> 	Arnd
>

