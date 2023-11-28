Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FqgFC6gQ"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C051BC2
	for <linux-serial@vger.kernel.org>; Tue, 28 Nov 2023 02:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701166410; x=1732702410;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+ZDIfNVeTWS2cwEGFjUJ1pM8fK01DrleOVyr1h2YLMI=;
  b=FqgFC6gQTWoh2VosyzXaxBABUe3EcEjjSmyEOdjcGIO7HlBEhIZSVUX2
   Ic0VyqbxS9ydPX2hOBx0QRzKuUtVGBgfLdxS8k6ZegY3vARAjhoIQ2ir9
   Kv2qjeO6LzYgsmRFK7bijizPInkBQKlJbL3FmAQWmHAmq7o4OrfPdGNru
   Dj0dSno6Dxk3UErx6IL1b1pBy0FjznCczPsPuRFBuCexRBG3zHb0aGMsD
   XKs66EuNvdfQfJmsO5416tilRRfPGU5yVuKev6pPfPwv4VSgbi9sCHj1i
   Vl3mpxNOtGBbyxeEp9b9V+Qq8hfyfjvC5kJsm7L7VqXGOQiAdIBKC8RiJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="396797373"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="396797373"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 02:13:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="859381490"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="859381490"
Received: from haslam-mobl1.ger.corp.intel.com ([10.252.43.79])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 02:13:28 -0800
Date: Tue, 28 Nov 2023 12:13:26 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Christina Quast <contact@christina-quast.de>
cc: Greg KH <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Daniel Beer <daniel.beer@igorinstitute.com>
Subject: Re: [PATCH v3 RESEND] hid-ft260: Add serial driver
In-Reply-To: <0fb134f7-f72e-4742-9c2d-c68f83b67975@christina-quast.de>
Message-ID: <aa99b5f-6f6e-47c7-5956-5034c681d0d7@linux.intel.com>
References: <20231122094004.95399-1-contact@christina-quast.de> <2023112205-explore-frequency-40a6@gregkh> <0fb134f7-f72e-4742-9c2d-c68f83b67975@christina-quast.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 26 Nov 2023, Christina Quast wrote:

> Hi Greg!
> 
> Thanks for the comments!
> 
> On 11/22/23 11:15, Greg KH wrote:
> > On Wed, Nov 22, 2023 at 10:40:03AM +0100, Christina Quast wrote:
> > > This commit adds a serial interface /dev/FTx which implements the tty
> > > serial driver ops, so that it is possible to set the baudrate, send
> > > and receive data, etc.
> > Why is this a serial device?  What type of device is it?
> > 
> > And why "FTx"?  Where did that name come from?  That's not a "normal"
> > tty name.
> I meant /dev/ttyFTx. Since it's a hid device providing a serial interface, in
> theory you could also call it /dev/ttySx or /dev/ttyUSBx, but both feel wrong.
> It's an FTDI device, that functions as a USB to UART / I2C Master. Do you have
> a better name in mind?

> > > +struct ft260_uart_write_request_report {
> > > +	u8 report;		/* FT260_UART_REPORT */
> > > +	u8 length;		/* data payload length */
> > > +	u8 data[];		/* data payload */
> > Shouldn't this be marked as counted by length?
> Do you mean in the comment?

No, try:

git grep __counted_by

> > > +		req.data_bit = FT260_CFG_DATA_BITS_8;
> > > +		termios->c_cflag &= ~CSIZE;
> > > +		termios->c_cflag |= CS8;
> > > +		break;
> > > +	default:
> > > +	case CS8:
> > > +		req.data_bit = FT260_CFG_DATA_BITS_8;
> > > +		break;
> > > +	}
> > > +
> > > +	req.stop_bit = (termios->c_cflag & CSTOPB) ?
> > > +		FT260_CFG_STOP_TWO_BIT : FT260_CFG_STOP_ONE_BIT;
> > > +
> > > +	if (termios->c_cflag & PARENB) {
> > > +		req.parity = (termios->c_cflag & PARODD) ?
> > > +			FT260_CFG_PAR_ODD : FT260_CFG_PAR_EVEN;
> > > +	} else {
> > > +		req.parity = FT260_CFG_PAR_NO;
> > > +	}
> > > +
> > > +	baud = tty_termios_baud_rate(termios);
> > > +	if (baud == 0 || baud < FT260_CFG_BAUD_MIN || baud >
> > > FT260_CFG_BAUD_MAX) {
> > > +		struct tty_struct *tty = tty_port_tty_get(&port->port);
> > Blank line needed here.
> > 
> > > +		hid_err(hdev, "Invalid baud rate %d\n", baud);
> > Again, debug error?  And why not report an error instead of just setting
> > it to 9600?
> > 
> > And why 9600?
> 
> This is a default setting used in the FT260 documentation as default value, so
> it seemed like a sensible value.
> 
> The ft260_uart_change_speed function is called in set_termios, which has a
> void return type. So even if I returned an error, that would not be propagated
> to userspace. It looks like the userspace is meant to check what values were
> actually set with a subsequent ioctl call.

Setting termios does not propagate errors (legacy feature, I don't know
the reason).

However, every set termios handling function should ensure if any value 
from the input termios is changed because the HW cannot do what has been 
requested, the changes should be reflected in the termios so that 
userspace knows about them (could check but I don't know if any userspace 
application actually does that, and I'm quite skeptical they would).

IIRC, termios is returned also from the setting call.


-- 
 i.

