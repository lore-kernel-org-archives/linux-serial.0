Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0AD140E29
	for <linux-serial@vger.kernel.org>; Wed, 17 Apr 2024 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368478; cv=none; b=e8FX7DgYmtxwzHtIznJ0TcLdx9pZAVGL5gTK2BC7ylDdpFoE36PZtWrmT3+iNF+aUYVszm7cFTlCuiPnoVfyLoMWJIPJPYFg/UyK3g6C1IrafjxiDAYYG7CyK6WRvbGLiAis8HZeolLIduIk8tsVJ/rSiUGAt1e11sbnWuL6Ozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368478; c=relaxed/simple;
	bh=ym8DvO8SRJOit/KXUFs6lvUuqHeyZurGWk3S7tYMlMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBCh/KnkjeaNM/FojJVZ6kP1qd51eZyqXDXTcj0grGPCgv1MnbAnDrCaggagUn6riHivOYPJuP0yWPgpKjx3QcwdvXV1vPbAETl1F2IgdLRm2qjuORP6pdVavtX/nE0DwhBKQQezzBpbsTtciFZtH1ymoIe4AwXGhQVejsSyU1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZBHZ14i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZBHZ14i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713368475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LQav6+KhkNcvzSqK0RSgvcrQ/+D1t9LYeHG/i6wdsbo=;
	b=SZBHZ14iIXcaF/0hLHYQjrj9oYUdtzO174ZZKc+n3GQCcORIRxkybr5Ic5JmvmkPAYJQZ5
	5Telp8rzazd7Uf8h+A8l4eAZPa0GNx51Lm5rgxjvpShIyQNkX6e+XgbTheaB6p2ml6oNAk
	htnmSdm7SVKVNCTYLA+ZffLxWmVIJIk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-EW278JR2NCiqTaIiMEgiHw-1; Wed, 17 Apr 2024 11:41:12 -0400
X-MC-Unique: EW278JR2NCiqTaIiMEgiHw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4C2210A2B48;
	Wed, 17 Apr 2024 15:41:11 +0000 (UTC)
Received: from fedora (unknown [10.22.9.10])
	by smtp.corp.redhat.com (Postfix) with SMTP id 8755B3543A;
	Wed, 17 Apr 2024 15:41:08 +0000 (UTC)
Date: Wed, 17 Apr 2024 12:41:07 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Michael Pratt <mcpratt@pm.me>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Vamshi Gajjela <vamshigajjela@google.com>
Subject: Re: [PATCH v2 1/3] serial: core: Store fifo timeout again
Message-ID: <2ofvmwtigayox5ilt62lececgol3jqqfisfhiz3bewugf4wime@fbz45h7ovyoa>
References: <20240416182741.22514-1-mcpratt@pm.me>
 <20240416182741.22514-2-mcpratt@pm.me>
 <Zh7KV0FuM2B56J7w@smile.fi.intel.com>
 <zTaajAZtS59Hv5offvbHJV1ptivBxD4WaZP_M-zQkicUtDb4mokpuKCFGIzUVL3p2yDSqHx9Uf2vIYVlbGeHN8xMJ6H3VWxwH3MPe1cH5a4=@pm.me>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zTaajAZtS59Hv5offvbHJV1ptivBxD4WaZP_M-zQkicUtDb4mokpuKCFGIzUVL3p2yDSqHx9Uf2vIYVlbGeHN8xMJ6H3VWxwH3MPe1cH5a4=@pm.me>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Tue, Apr 16, 2024 at 07:20:18PM +0000, Michael Pratt wrote:
> Hi Andy,
> 
> On Tuesday, April 16th, 2024 at 14:58, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > ...
> > 
> > > + if (port->fifosize > 1)
> > > + port->timeout = uart_fifo_timeout(port);
> > 
> > 
> > else
> > port->timeout = port->frame_time;
> > 
> 
> 
> Consistent with what I said in the other reply, the only reason that
> I have an if statement here, is to avoid doing extra math for devices
> without a fifo, as a specifically calculated timeout value would be useless
> in those cases.
> 

As we are talking about a device with a scale of KB/s, I am attempted to
suggest to call uart_fifo_timeout() unconditionally.

> However, if you don't like the 10 ms default timeout, perhaps port->frame_time
> could actually be a more reasonable default value? That is, provided that we have a process
> for calculating the proper value already in place...
> 
> > 
> > --
> > With Best Regards,
> > Andy Shevchenko
> 
> 
> 
> Thanks for taking a look :D
> 
> --
> MCP
> 

