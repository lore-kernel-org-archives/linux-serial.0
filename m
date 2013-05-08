From: Stuart MENEFY <stuart.menefy@st.com>
Subject: Re: [RFC 2/8] ARM:global_timer: Add ARM global timer support.
Date: Wed, 08 May 2013 16:48:31 +0100
Message-ID: <518A73CF.8000309@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022260-2197-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081638.23100.arnd@arndb.de>
 <20130508144907.GB20820@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130508144907.GB20820@mudshark.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Dave Martin <dave.martin@linaro.org>, Srinivas KANDAGATLA <srinivas.kandagatla@st.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Jiri Slaby <jslaby@suse.cz>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Nicolas Pitre <nico@linaro.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Stephen Warren <swarren@nvidia.com>, Dong Aisheng <dong.aisheng@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg
List-Id: linux-serial@vger.kernel.org

On 08/05/13 15:49, Will Deacon wrote:
> On Wed, May 08, 2013 at 03:38:22PM +0100, Arnd Bergmann wrote:
>> On Wednesday 08 May 2013, Srinivas KANDAGATLA wrote:
>>> From: Stuart Menefy <stuart.menefy@st.com>
>>>
>>> This is a simple driver for the global timer module found in the Cortex
>>> A9-MP cores from revision r1p0 onwards. This should be able to perform
>>> the functions of the system timer and the local timer in an SMP system.
>>>
>>> The global timer has the following features:
>>>     The global timer is a 64-bit incrementing counter with an
>>> auto-incrementing feature. It continues incrementing after sending
>>> interrupts. The global timer is memory mapped in the private memory
>>> region.
>>>     The global timer is accessible to all Cortex-A9 processors in the
>>> cluster. Each Cortex-A9 processor has a private 64-bit comparator that
>>> is used to assert a private interrupt when the global timer has reached
>>> the comparator value. All the Cortex-A9 processors in a design use the
>>> banked ID, ID27, for this interrupt. ID27 is sent to the Interrupt
>>> Controller as a Private Peripheral Interrupt. The global timer is
>>> clocked by PERIPHCLK.
>>>
>>> Signed-off-by: Stuart Menefy <stuart.menefy@st.com>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>>>
>>
>> Are you sure we don't already have a driver for this? It sounds unlikely
>> that you are the first one to do this when the hardware is so common.
> 
> An additional reason why people don't make use of this timer (on top of the
> power domain concerns raised by Rob) is due to the following from the A9
> TRM:
> 
>   `From r2p0 the comparators for each processor with the global timer fire
>    when the timer value is greater than or equal to. In previous revisions
>    the comparators fired when the timer value was equal to.'
> 
> So you'll get into all sorts of horrible races on those older revisions if
> you're not careful.

Fortunately the earliest version of these SoCs uses r2p2, so we avoided that
particular issue. But as the code doesn't attempt to work around these
problems a check on the version number might be a good idea to prevent other
people accidentally hitting it.

Stuart
