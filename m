From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [RFC 1/8] serial:st-asc: Add ST ASC driver.
Date: Fri, 10 May 2013 16:45:15 +0200
Message-ID: <518D07FB.7010606@codethink.co.uk>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022248-2153-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081634.43498.arnd@arndb.de> <20130508153459.GA17186@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130508153459.GA17186@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Martin <dave.martin@linaro.org>, Srinivas KANDAGATLA <srinivas.kandagatla@st.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Grant Likely <grant.likely@secretlab.ca>, jslaby@suse.cz, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Nicolas Pitre <nico@linaro.org>, linux-doc@vger.kernel.org, Stephen Gallimore <stephen.gallimore@st.com>, linux-serial@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Stuart Menefy <stuart.menefy@st.com>, Stephen Warren <swarren@nvidia.com>, Dong Aisheng <dong.aisheng@linaro.org>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kerne
List-Id: linux-serial@vger.kernel.org

On 08/05/13 17:34, Greg KH wrote:
> On Wed, May 08, 2013 at 04:34:43PM +0200, Arnd Bergmann wrote:
>>> +#define ASC_MAJOR		204
>>> +#define ASC_MINOR_START		40
>>
>> I don't know what the current policy is on allocating major/minor numbers,
>> but I'm sure you cannot just reuse one that is already used.
>
> I agree, why are you trying to create a new tty device name?  Can't you
> use the existing ttyS name and minor number as you will not have any
> other type of serial device on this system?

This would be an issue on systems that either accept plug-in cards
such as PCMCIA/CardBus/PCI or have additional off SoC IO spaces
where 8250 compatible UARTS could live.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
