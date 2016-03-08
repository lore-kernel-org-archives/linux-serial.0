From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] tty: amba-pl011: use sg_table instead of scatterlist
Date: Tue, 8 Mar 2016 09:59:07 +0000
Message-ID: <20160308095907.GM19428@n2100.arm.linux.org.uk>
References: <1457405016-23562-1-git-send-email-chanho.min@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457405016-23562-1-git-send-email-chanho.min@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanho Min <chanho.min@lge.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jongsung Kim <neidhard.kim@lge.com>, Gunho Lee <gunho.lee@lge.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 08, 2016 at 11:43:36AM +0900, Chanho Min wrote:
> The use of phys_to_page is wrong in commit cb06ff102e2d ("ARM: PL011:
> Add support for Rx DMA buffer polling."), beacase DMA address is not
> physical address. Also, phys_to_page is not declared in some architecture.
> The use of virt_to_page is wrong as well because dma_alloc_coherent
> implementaion are allowed to returned remapped memory. So I use sg_table
> instead of scatterlist and change to dma_get_sgtable() implementaion.

dma_get_sgtable() is also broken.

> @@ -344,17 +344,23 @@ static int pl011_sgbuf_init(struct dma_chan *chan, struct pl011_sgbuf *sg,
>  	enum dma_data_direction dir)
>  {
>  	dma_addr_t dma_addr;
> +	int ret;
>  
>  	sg->buf = dma_alloc_coherent(chan->device->dev,
>  		PL011_DMA_BUFFER_SIZE, &dma_addr, GFP_KERNEL);
>  	if (!sg->buf)
>  		return -ENOMEM;

sg->buf can be a mapped address, which virt_to_page() will return invalid
results:

int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
                 void *cpu_addr, dma_addr_t handle, size_t size)
{
        struct page *page = virt_to_page(cpu_addr);
        int ret;

        ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
        if (unlikely(ret))
                return ret;

        sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
        return 0;
}
EXPORT_SYMBOL(dma_common_get_sgtable);

I've no idea who is shoveling crap like this into the kernel, but it's
_really_ far from good that such broken abstractions are being merged
as generic code.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
