From: Stephen GALLIMORE <stephen.gallimore@st.com>
Subject: RE: [RFC 1/8] serial:st-asc: Add ST ASC driver.
Date: Wed, 8 May 2013 18:10:48 +0200
Message-ID: <A3BF01DB4A606149A4C20C4C4C808F6C3189E576C2@SAFEX1MAIL1.st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022248-2153-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081634.43498.arnd@arndb.de> <20130508153459.GA17186@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130508153459.GA17186@kroah.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg KH <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Srinivas KANDAGATLA <srinivas.kandagatla@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stuart MENEFY <stuart.menefy@st.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org


>On Wed, May 08, 2013 at 04:34:43PM +0200, Arnd Bergmann wrote:
> > > +#define ASC_MAJOR		204
> > > +#define ASC_MINOR_START		40
> > 
> > I don't know what the current policy is on allocating major/minor 
> > numbers, but I'm sure you cannot just reuse one that is already used.

First, our apologies, this issue was raised internally and then got forgotten about, there's always something I guess.
 
> >I agree, why are you trying to create a new tty device name?  Can't you use the existing ttyS name and minor number as you will not have any other type of serial
> >device on this system?

That is an interesting question Greg; I believe it probably stems from historic ST SoCs that had two different types of serial devices, something that is no longer the case. We will review our approach to this again, although we are not sure we can use the existing ttyS major/minor (even if that is an acceptable thing to do) because of the (remote) possibility of someone using a standard PCIe attached serial card.

Regards,
-stephen
