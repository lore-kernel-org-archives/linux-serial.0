From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: Re: [PATCH v2 04/11] mfd:stixxxx-syscfg: Add ST System Configuration
 support.
Date: Tue, 11 Jun 2013 08:41:19 +0100
Message-ID: <51B6D49F.3030203@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com> <CACRpkdaW2ALTWCB7Rd8m=aAGQwh3T_dJVncxJn_eXer4X3J6_g@mail.gmail.com> <51B5DA26.6070707@st.com> <2757224.FBxg98dX57@wuerfel>
Reply-To: srinivas.kandagatla@st.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <2757224.FBxg98dX57@wuerfel>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, "David S. Miller" <davem@davemloft.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Stephen Gallimore <stephen.gallimore@st.com>, Rob Herring <rob.herring@calxeda.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stuart Menefy <stuart.menefy@st.com>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@redhat.com>
List-Id: linux-serial@vger.kernel.org

On 10/06/13 15:02, Arnd Bergmann wrote:
> There are multiple ways of doing that, e.g. you could export a function
> from syscon.c that you call to register the device node and then import
> the regmap from syscon into your high-level driver again.
> 

Hi Arnd/Linus,

Thankyou for your comments,
I did try using the full sysconf names in compatible and make use of
syscon driver, with this change the nodes look much neater.

The nodes changes to:

syscfg_sbc:syscfg@fe600000{
    compatible      = "st,stih416-sbc-syscfg", "syscon";
    reg             = <0xfe600000 0x1000>;
};

From:
syscfg_sbc:syscfg@fe600000{
         compatible      = "st,stih416-syscfg";
         reg             = <0xfe600000 0x1000>;
         syscfg-range    = <0 999>;
         syscfg-name     = "SYSCFG_SBC";
};


Also I got rid of the drivers/mfd/stixxxx-syscfg.c driver all together
for this basic support patch series, I will add this once there are new
high level functions.
Additional compatible string will allow code to get to regmap via syscon
apis.

I will get rid of this driver in next version for this series.

Thanks,
srini

> 	Arnd
> 
> 

