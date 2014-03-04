From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC 3/6] tty: Rename xilinx_uart -> cadence_uart
Date: Tue, 4 Mar 2014 23:16:26 +0100
Message-ID: <201403042316.26221.arnd@arndb.de>
References: <1393953449-28551-1-git-send-email-soren.brinkmann@xilinx.com>
 <1393953449-28551-4-git-send-email-soren.brinkmann@xilinx.com>
 <20140304193913.71c6f307@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140304193913.71c6f307@alan.etchedpixels.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Peter Crosthwaite <peter.crosthwaite@xilinx.com>, Kevin Hilman <khilman@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Olof Johansson <olof@lixom.net>, Jiri Slaby <jslaby@suse.cz>, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

On Tuesday 04 March 2014, One Thousand Gnomes wrote:
> On Tue,  4 Mar 2014 09:17:26 -0800
> Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:

> The following aspects of the change set are IMHO acceptable
> 
> - Cleaning up all the code formatting
> - Update the driver comments and header to explain the Cadence/Xilinx
>   thing
> - change "Xilinx PS UART Support" text to "Cadence (Xilinx PS) Support"
>   or similar wording in Kconfig
> - Adding the cadence devicetree compatibility strings and inputs *in
>   addition* to the existing ones.
> - Documentation for the new options

I agree. I think it would also be nice to allow the standard clock names
to be used as an alternative to the bogus ref_clk" and "aper_clk"
names, but just like the compatible string, it's too late to remove
support for the existing ones.

Regarding the "xlnx,xuartps" compatible string, even if we were to break
backwards comptibility with the clocks, I would still want to see this
string being used in addition to "cdns,uart-r1p8" so we have a way to
detect possible changes that xilinx did on top of the r1p8 version.
I also wonder if "cdns,uart-r1p8" is actually specific enough: r1p8
looks like a version number rather than a name, and it seems possible
that Cadence has produced more than one uart implemention in the past
or will do another one in the future that is not just a different
revision of this one but instead something completely different.

	Arnd
