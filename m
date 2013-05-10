From: Stuart MENEFY <stuart.menefy@st.com>
Subject: Re: [RFC 1/8] serial:st-asc: Add ST ASC driver.
Date: Fri, 10 May 2013 16:40:58 +0100
Message-ID: <518D150A.7030807@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022248-2153-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081634.43498.arnd@arndb.de> <20130508153459.GA17186@kroah.com>
 <518D07FB.7010606@codethink.co.uk> <20130510152355.GB11227@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130510152355.GB11227@kroah.com>
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
Cc: Dave Martin <dave.martin@linaro.org>, Srinivas KANDAGATLA <srinivas.kandagatla@st.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Grant Likely <grant.likely@secretlab.ca>, jslaby@suse.cz, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Nicolas Pitre <nico@linaro.org>, linux-doc@vger.kernel.org, Stephen Gallimore <stephen.gallimore@st.com>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-serial@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Stephen Warren <swarren@nvidia.com>, Dong Aisheng <dong.aisheng@linaro.org>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kern
List-Id: linux-serial@vger.kernel.org

On 10/05/13 16:23, Greg KH wrote:
> On Fri, May 10, 2013 at 04:45:15PM +0200, Ben Dooks wrote:
>> On 08/05/13 17:34, Greg KH wrote:
>>> On Wed, May 08, 2013 at 04:34:43PM +0200, Arnd Bergmann wrote:
>>>>> +#define ASC_MAJOR		204
>>>>> +#define ASC_MINOR_START		40
>>>>
>>>> I don't know what the current policy is on allocating major/minor numbers,
>>>> but I'm sure you cannot just reuse one that is already used.
>>>
>>> I agree, why are you trying to create a new tty device name?  Can't you
>>> use the existing ttyS name and minor number as you will not have any
>>> other type of serial device on this system?
>>
>> This would be an issue on systems that either accept plug-in cards
>> such as PCMCIA/CardBus/PCI or have additional off SoC IO spaces
>> where 8250 compatible UARTS could live.
> 
> I thought these were set-top box systems that couldn't accept any
> plug-in cards or anything else?  This is a SoC, right?

Correct, it is a SoC intended for set-top-box systems. But they are also
expandable and have a PCIe root complex. In the final system this would
normally be used for things like WiFi, but in development boards these
are brought out to generic PCIe slots where pretty much anything can be
plugged in.

We've also had systems in the dim and distant past which used memory
mapped external super I/O controllers which had 8250 compatible serial
ports.

So while its not usual, we have had systems with both ASC and 8250
compatible serial ports, which is why we'd like to keep the option open.

Stuart
