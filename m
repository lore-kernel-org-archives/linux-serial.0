From: Chanho Min <chanho.min@lge.com>
Subject: RE: [PATCH] tty: amba-pl011: use sg_table instead of scatterlist
Date: Wed, 9 Mar 2016 09:15:36 +0900
Message-ID: <05b701d17998$cdd9adc0$698d0940$@lge.com>
References: <1457405016-23562-1-git-send-email-chanho.min@lge.com> <20160308095907.GM19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160308095907.GM19428@n2100.arm.linux.org.uk>
Content-Language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Jiri Slaby' <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 'Jongsung Kim' <neidhard.kim@lge.com>, 'Gunho Lee' <gunho.lee@lge.com>
List-Id: linux-serial@vger.kernel.org

> > @@ -344,17 +344,23 @@ static int pl011_sgbuf_init(struct dma_chan *chan,
> struct pl011_sgbuf *sg,
> >  	enum dma_data_direction dir)
> >  {
> >  	dma_addr_t dma_addr;
> > +	int ret;
> >
> >  	sg->buf = dma_alloc_coherent(chan->device->dev,
> >  		PL011_DMA_BUFFER_SIZE, &dma_addr, GFP_KERNEL);
> >  	if (!sg->buf)
> >  		return -ENOMEM;
> 
> sg->buf can be a mapped address, which virt_to_page() will return
> sg->invalid
> results:
> 
> int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
>                  void *cpu_addr, dma_addr_t handle, size_t size) {
>         struct page *page = virt_to_page(cpu_addr);
>         int ret;
> 
>         ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
>         if (unlikely(ret))
>                 return ret;
> 
>         sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
>         return 0;
> }
> EXPORT_SYMBOL(dma_common_get_sgtable);
> 
> I've no idea who is shoveling crap like this into the kernel, but it's
> _really_ far from good that such broken abstractions are being merged as
> generic code.

dma_get_sgtable goes to ops->get_sgtable first, which dma_to_pfn
will return valid address.
IMHO, Only If ops->alloc returns direct mapping address,
dma_common_get_sgtable can be used.

int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
                 void *cpu_addr, dma_addr_t handle, size_t size,
                 struct dma_attrs *attrs)
{
        struct page *page = pfn_to_page(dma_to_pfn(dev, handle));
        int ret;
