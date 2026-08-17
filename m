Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A58943802D;
	Mon, 17 Aug 2026 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786978192; cv=none; b=Bwn062XHuqojhnv+iiodl1zfS5TwLIIt+h+KwqwHcyCqfhad02LgXoUPigv1nW0XoHmvrJuvladGK/WbaxnD2J8gnxCtKGwaBkDt9c4xiKz1cUEsbsnnKFio78679evXbk5nxc+WUva4suU3Us2C4My/Df93LO9jegJDJslm224=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786978192; c=relaxed/simple;
	bh=KfECN69w/TPxHqoXyrsdem0QIzJouHaXDlm/0CinOp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqRN6CiDd7XP8Um78Nc3KGJgHZJODzx42RdmqFxamwzZlZ5ctVeKI3w/48ReCqpBa2poEfZAoe9MqGDGNRkuMlBk6h/p6IMN3FfeBBMR8rFInwN3sLGdgD0CoJ7ChTzWL0U8FhYS93kxg2LkeAb5iHZ08pVdwEotPWAqIwGA5/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c65g+AtD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c65g+AtD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9951F00A3A;
	Mon, 17 Aug 2026 14:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786978190;
	bh=mDUF539j+O00tZHsl3tRklIiI9rfavWcDD68et0uSwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c65g+AtD6f4FghVbtcDQWIGZEGuMg8Vs/Pr87+woNhjXMWuEZcaq0NAOjViLrkJND
	 S4LZHmtd6+kDIg9ZUfr7MCPNH4FiIT/jHBnHHKVBdxcDefBZVWrwSR6jLTbLsugLka
	 y5sittjTNcGRTZUesBXjNqJ9xi/DYudygvDgBnZA=
Date: Mon, 17 Aug 2026 16:49:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xin Chen <xin.chen2@oss.qualcomm.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, liulzhao@qti.qualcomm.com,
	cheng.jiang@oss.qualcomm.com
Subject: Re: [PATCH v1] tty: n_tty: use kvzalloc/kvfree for line discipline
 data
Message-ID: <2026081747-secret-partly-158a@gregkh>
References: <20260817135526.386863-1-xin.chen2@oss.qualcomm.com>
 <2026081706-tricky-slicing-166f@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026081706-tricky-slicing-166f@gregkh>

On Mon, Aug 17, 2026 at 04:16:53PM +0200, Greg KH wrote:
> On Mon, Aug 17, 2026 at 09:55:26PM +0800, Xin Chen wrote:
> > BT enable fails intermittently with -ETIMEDOUT (-110).  The kernel log
> > shows the HCI Read Local Version command was sent and the firmware
> > replied with status 0x00 (logged by hci_req_cmd_complete() BT_DBG),
> > but the waiter in __hci_cmd_sync_sk() never woke up and timed out
> > after 10 s:
> > 
> >   bluetooth hci0: Opcode 0xfc00              // __hci_cmd_sync_sk
> >   bluetooth hci0: opcode 0xfc00 plen 1       // hci_cmd_sync_add
> >   bluetooth hci0: skb len 4                  // hci_cmd_sync_alloc
> >   bluetooth hci0: length 1                   // hci_req_sync_run
> >   Bluetooth: hci0 cmd_cnt 1 cmd queued 1     // hci_cmd_work
> >   Bluetooth: hci0 type 1 len 4               // hci_send_frame
> >   Bluetooth: opcode 0xfc00 status 0x00       // hci_req_cmd_complete
> >   <-- req_skb NULL: req_complete_skb not set,
> >       hci_cmd_sync_complete() never called,
> >       req_status stays HCI_REQ_PEND            -->
> >   <-- 10 s later: wait_event_interruptible_timeout expires -->
> >   bluetooth hci0: end: err -110              // __hci_cmd_sync_sk
> > 
> > The root cause is that hci_send_cmd_sync() clones the sent command
> > into hdev->req_skb so that hci_req_cmd_complete() can locate the
> > registered completion callback.  Under memory pressure this
> > skb_clone() fails, leaving hdev->req_skb NULL.  The firmware reply
> > is received and processed, but hci_req_cmd_complete() finds NULL
> > req_skb, so hci_cmd_sync_complete() is never called, req_status
> > stays HCI_REQ_PEND, and the waiter times out with -ETIMEDOUT.
> > 
> > The memory pressure is caused by n_tty_open().  When a BT UART
> > transport is opened, serdev_device_open() may be called multiple
> > times in quick succession, each triggering n_tty_open().  n_tty_open()
> > uses vzalloc() for the ~10 KB n_tty_data structure, which always
> > allocates page-by-page from the buddy order-0 free list.  Repeated
> > vzalloc() calls drain enough order-0 pages that the subsequent
> > skb_clone(GFP_KERNEL) in hci_send_cmd_sync() cannot get a page.
> 
> So you run out of memory?  That feels wrong.

Also, you are papering over the real problem here.  If this one
allocation is failing, what keeps the next one from failing and then the
skb will not be able to be allocated?

Why is the system so out of memory in this slab that this is happening?
What changed in the tty layer to cause this?  Or did it happen
elsewhere?

And no cc: stable or Fixes: tag?

thanks,

greg k-h
