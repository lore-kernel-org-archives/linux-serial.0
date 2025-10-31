Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9626A33987;
	Fri, 31 Oct 2025 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928254; cv=none; b=pw3cyiOwm9jUS1B898itAgvMAFK+UcLzdPfqTCYG0ORIdfoDo5Kvl6mShouJTWkJHR+VYFHjjPHdsZ7rHtLLcIif3UpSdvpzEJsfiaFr/bZ5aXoy7LqgECZ8oW4V7MxS9Bh9AWY+OX6EbIHIkoywjiWN6wWRL4X7PFexWds50lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928254; c=relaxed/simple;
	bh=DPYN5cD7LqmkqnhJDPlutbIISQPyNyW8OlZfHe2zW8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMoFb3EjJszE4kypJJ5FDLAv8LuUsjZ6Zc9+WiMWtAWCwRdwQSFwYDDY5zY2Pl42OevFPLEVyp3k1I0Dc8j/MNf9UTcVNJLTZPtcAFpyLyrMKJYE/dtpMwRI7fKdyN41SwEEGLbp1zMAIBEA6HXqYpEckVUDxIM6R5+e7RTgAkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QhpH9OWU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QhpH9OWU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A52C4CEE7;
	Fri, 31 Oct 2025 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761928254;
	bh=DPYN5cD7LqmkqnhJDPlutbIISQPyNyW8OlZfHe2zW8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QhpH9OWUOLDiL083ozNGkbZW0Itze6RFEmP8zTNj5wWjyijpvuUJPis39K3dXBHWv
	 vF7m4TpK7NUPvFEQ5B+yZY/3+4W011//mBV/3uo5LPNjDQemZlQn4x7VJufehLuv8T
	 fHh0M5fVIXLqIUPLFT13LneZLQmeF7eCHMKLsFBw=
Date: Fri, 31 Oct 2025 17:30:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Jiri Slaby <jirislaby@kernel.org>,
	Haowei Zheng <zhenghaowei@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	ilpo.jarvinen@linux.intel.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 0/3] uart: Introduce uart driver for the Loongson
 family
Message-ID: <2025103139-overlabor-subsector-7f8e@gregkh>
References: <cover.1760166651.git.zhoubinbin@loongson.cn>
 <CAMpQs4L4A5pPG0pAKiua_2q3rBQB3WETBjc8iG8mbz5U1tWR7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpQs4L4A5pPG0pAKiua_2q3rBQB3WETBjc8iG8mbz5U1tWR7g@mail.gmail.com>

On Fri, Oct 31, 2025 at 10:36:00AM +0800, Binbin Zhou wrote:
> On Sat, Oct 11, 2025 at 3:17 PM Binbin Zhou <zhoubinbin@loongson.cn> wrote:
> >
> > Hi all:
> >
> > For various reasons, I will be taking over from Haowei and continuing to
> > push forward with this patch set. Thanks to Haowei for his efforts so
> > far.
> >
> > This patchset introduce a generic UART framework driver for Loongson family.
> > It can be found on Loongson3 series cpus, Loongson-2K series cpus and Loongson
> > LS7A bridge chips.
> >
> > Thanks.
> >
> > ------
> > V6:
> > Patch-1:
> >  - Add Conor's Acked-by tag, thanks.
> >
> > Patch-2:
> >  - Add more missing #include;
> >  - Convert mcr_invert/msr_invert from int to u8;
> >  - Split serial_fixup() on a preceding line;
> >  - Add macro definition to avoid magic numbers, such as
> >    LOONGSON_QUOT_FRAC_MASK;
> >  - Rework the relevant data structures, where `loongson_uart_ddata`
> >    represents the Soc's driver_data;
> >  - Drop `PORT_LOONGSON` and use PORT_16550A instead.
> >  - devm_platform_get_and_ioremap_resource() instead of platform_get_resource();
> >  - Use uart_read_port_properties() and parse the clock attributes;
> >  - Use switch-case instead of if-else in serial_fixup().
> >
> > Link to V5:
> > https://lore.kernel.org/all/cover.1758676290.git.zhoubinbin@loongson.cn/
> 
> Hi all:
> 
> Gentle ping.
> Any comments about this patchset ?

Sorry, will try to get to it next week...
