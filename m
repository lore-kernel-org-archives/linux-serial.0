Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44928183;
	Mon, 27 Nov 2023 23:40:24 -0800 (PST)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 7B50D2074D;
	Tue, 28 Nov 2023 08:40:22 +0100 (CET)
Date: Tue, 28 Nov 2023 08:40:21 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 1/3] Bluetooth: btnxpuart: fix recv_buf() return value
Message-ID: <ZWWZZQUzZpnTm4i5@francesco-nb.int.toradex.com>
References: <20231127191409.151254-1-francesco@dolcini.it>
 <20231127191409.151254-2-francesco@dolcini.it>
 <5f2995d5-3c7c-4234-82ef-dd43bc73a730@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f2995d5-3c7c-4234-82ef-dd43bc73a730@kernel.org>

On Tue, Nov 28, 2023 at 06:23:21AM +0100, Jiri Slaby wrote:
> On 27. 11. 23, 20:14, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > Serdev recv_buf() callback is supposed to return the amount of bytes
> > consumed, therefore an int in between 0 and count.
> > 
> > Do not return negative number in case of issue, just print an error and
> > return count.  This fixes a WARN in ttyport_receive_buf().

...

> >   drivers/bluetooth/btnxpuart.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
> > index b7e66b7ac570..951fe3014a3f 100644
> > --- a/drivers/bluetooth/btnxpuart.c
> > +++ b/drivers/bluetooth/btnxpuart.c
> > @@ -1276,11 +1276,10 @@ static int btnxpuart_receive_buf(struct serdev_device *serdev, const u8 *data,
> >   	if (IS_ERR(nxpdev->rx_skb)) {
> >   		int err = PTR_ERR(nxpdev->rx_skb);
> >   		/* Safe to ignore out-of-sync bootloader signatures */
> > -		if (is_fw_downloading(nxpdev))
> > -			return count;
> > -		bt_dev_err(nxpdev->hdev, "Frame reassembly failed (%d)", err);
> > +		if (!is_fw_downloading(nxpdev))
> > +			bt_dev_err(nxpdev->hdev, "Frame reassembly failed (%d)", err);
> >   		nxpdev->rx_skb = NULL;
> 
> Is this NULLing not needed in the good case?
NULLing in the good case would be a bug, in addition to that NULLing is
not needed at all even in the bad case and it will be removed in the
last patch, as a cleanup. Here I just maintained the existing logic.

> > -		return err;
> > +		return count;
> 
> Should you return 0? I don't know, maybe not
My reasoning is that we have some corrupted data, so we should just
use it all and maybe we'll get something valid at a later point, this is
what was already done before this change in the is_fw_downloading()
branch.

In my specific case it makes no difference, it will never recover from
this state.

Any other opinion?

> but you should document it in the commit log.
Ack

Francesco

