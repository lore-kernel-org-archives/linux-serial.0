From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: Add wch382_2s PCI ID
Date: Wed, 30 Dec 2015 12:45:34 +0530
Message-ID: <20151230071534.GA10343@sudip-pc>
References: <1451341594.11842.9.camel@zimage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-parport-bounces+linux-parport-2=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1451341594.11842.9.camel@zimage.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-parport>,
 <mailto:linux-parport-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-parport/>
List-Post: <mailto:linux-parport@lists.infradead.org>
List-Help: <mailto:linux-parport-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-parport>,
 <mailto:linux-parport-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-parport" <linux-parport-bounces@lists.infradead.org>
Errors-To: linux-parport-bounces+linux-parport-2=m.gmane.org@lists.infradead.org
To: Jeff Gustafson <ncjeffgus@zimage.com>
Cc: Linux-parport@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 28, 2015 at 02:26:34PM -0800, Jeff Gustafson wrote:
> Hi all,

Adding Cc to linux-serial@vger.kernel.org.

> I purchased a two port PCIe serial board. Linux didn't seem to notice
> it. I dug into the parport and tty/serial/8250 and added the PCI ID's.
> Now the ports are working just fine.=A0

Your device seems to have only serial ports. I think 8250_pci should be
able to handle it properly.
At a first glance this device is already there in 8250_pci as
PCI_DEVICE_ID_WCH_CH352_2S. Maybe you need to debug why it is not being
noticed.

regards
sudip
