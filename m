From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] serial: 8250: Fix THRE flag usage for CAP_MINI
Date: Wed, 28 Jun 2017 11:18:20 +0300
Message-ID: <1498637900.22624.214.camel@linux.intel.com>
References: <1498485581-72097-1-git-send-email-phil@raspberrypi.org>
 <627a530c-d78c-5338-5ddf-0b3f6a09c37e@i2se.com>
 <bf050731-6b05-9e35-8b50-ea9115b4197f@raspberrypi.org>
 <1498554936.22624.180.camel@linux.intel.com>
 <2669bcda-e1f5-ecb1-a986-99947658bac7@raspberrypi.org>
 <1498585950.22624.210.camel@linux.intel.com>
 <aeee2737-623c-c45b-bb18-4ff488684d0c@raspberrypi.org>
 <1498636112.22624.212.camel@linux.intel.com>
 <9d796427-3a02-53a6-5426-633bbf6f9a85@raspberrypi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <9d796427-3a02-53a6-5426-633bbf6f9a85-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2017-06-28 at 09:09 +0100, Phil Elwell wrote:
> On 28/06/2017 08:48, Andy Shevchenko wrote:
> > On Tue, 2017-06-27 at 22:00 +0100, Phil Elwell wrote:
> > > On 27/06/2017 18:52, Andy Shevchenko wrote:
> > > > On Tue, 2017-06-27 at 11:30 +0100, Phil Elwell wrote:
> > > > > On 27/06/2017 10:15, Andy Shevchenko wrote:


> > > > Okay, we have several types of flags in the code
> > > > 1. Capabilities: UART_CAP: looks like it defines features of
> > > > hardware
> > > > solely for 8250 compatible devices.
> > > > 2. Flags as quirks UPF_<something, not all of them> (I have a
> > > > patch
> > > > to
> > > > convert them to quirks, need by the way to update and resend):
> > > > they
> > > > are
> > > > for any serial devices.
> > > > 3. Flags as capabilities: UPF_<the rest>, similar function as
> > > > UART_CAP,
> > > > but for any serial device.
> > > > 
> > > > > 
> > > > > I'm also happy to make this code conditional on
> > > > > CONFIG_SERIAL_8250_BCM2835AUX
> > > > > if that is more acceptable.
> > > > 
> > > > No, it is undesired.
> > > > 
> > > > Can you describe which one from the above suits the best for
> > > > your
> > > > case?
> > > 
> > > This bug I am trying to work around is found in the 8250
> > > implementation of
> > > one family of CPUs, so I would say capabilities are the best fit
> > > because
> > > they are specific to 8250 drivers.
> > 
> > Yeah, looks like UART_CAP suits the best for now.
> > 
> > One more comment that UART_CAP_* gather capabilities and quirks at
> > the
> > same time.
> 
> Is that a request for an additional comment?

No.

>  Is there anything else needed
> for an ack?

No, fine by me. Just resend a new version with tags applied. It would be
easier for Greg to pick up it later.

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
