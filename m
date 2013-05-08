From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: Re: [RFC 1/8] serial:st-asc: Add ST ASC driver.
Date: Wed, 08 May 2013 19:18:02 +0100
Message-ID: <518A96DA.5060809@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022248-2153-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081634.43498.arnd@arndb.de> <20130508143908.GJ24282@game.jcrosoft.org>
Reply-To: srinivas.kandagatla@st.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130508143908.GJ24282@game.jcrosoft.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, devicetree-discuss@lists.ozlabs.org, Nicolas Pitre <nico@linaro.org>, Will Deacon <will.deacon@arm.com>, Stephen Gallimore <stephen.gallimore@st.com>, Rob Herring <rob.herring@calxeda.com>, linux-kernel@vger.kernel.org, Stuart Menefy <stuart.menefy@st.com>, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, Stephen Warren <swarren@nvidia.com>, Dong Aisheng <dong.aisheng@linaro.org>, jslaby@suse.cz, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-serial@vger.kernel.org

On 08/05/13 15:39, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> +
>> > 
>> > Please remove all forward declarations, by reordering the functions in
>> > the way they are called.
>> > 
> and drop the dummy functions
We can not remove the dummy functions, as the serial-core does not check
it before using them.
>> > 
>>> > > diff --git a/drivers/tty/serial/st-asc.h b/drivers/tty/serial/st-asc.h
>>> > > new file mode 100644
>>> > > index 0000000..e59f818
>>> > > --- /dev/null
>>> > > +++ b/drivers/tty/serial/st-asc.h
