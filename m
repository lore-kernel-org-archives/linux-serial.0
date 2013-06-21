From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: Re: [PATCH v3 01/10] serial:st-asc: Add ST ASC driver.
Date: Fri, 21 Jun 2013 14:50:55 +0100
Message-ID: <51C45A3F.7000009@st.com>
References: <1371736996-8770-1-git-send-email-srinivas.kandagatla@st.com> <1371737103-8871-1-git-send-email-srinivas.kandagatla@st.com> <201306202101.11261.arnd@arndb.de>
Reply-To: srinivas.kandagatla@st.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <201306202101.11261.arnd@arndb.de>
Sender: linux-doc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, kernel@stlinux.com, linux-doc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Stephen Gallimore <stephen.gallimore@st.com>, Stuart Menefy <stuart.menefy@st.com>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Rob Landley <rob@landley.net>, linux-serial@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.cz>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Greg,
If its not too late can this patch be considered for 3.11 via tty tree?
Arnd preferred to take the SOC patches in this series via arm-soc tree.
Also, there is no build dependency for this patch.

Thanks,
srini

On 20/06/13 20:01, Arnd Bergmann wrote:
> On Thursday 20 June 2013, Srinivas KANDAGATLA wrote:
>> This patch adds support to ASC (asynchronous serial controller)
>> driver, which is basically a standard serial driver. This IP is common
>> across all the ST parts for settop box platforms.
>>
>> ASC is embedded in ST COMMS IP block. It supports Rx & Tx functionality.
>> It support all industry standard baud rates.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>> CC: Stephen Gallimore <stephen.gallimore@st.com>
>> CC: Stuart Menefy <stuart.menefy@st.com>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
>>From my point of view the series is ready for merging in 3.11,
> I only had a few final comments. I would prefer the first three
> patches to go through the respective serial/clocksource/pinctrl
> trees, since there are no direct build dependencies to the
> platform parts.
> 
> If there is a reason to take those through arm-soc, I would
> insist on getting Acked-by's from the subsystem maintainers.
> 
> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 

