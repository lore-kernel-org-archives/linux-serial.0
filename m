Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CF4390C8C;
	Sat,  5 Sep 2026 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788619828; cv=none; b=qowuPm877kY5CsyyQgr0UaA5OD5R5l2w/ZQ3kdw3d5VxKZrh9A/kBswyIBALlLCsd8IyzDrlaeMVNceXF4k0I8kQk5+hlY4FQenYFBLXbqeyXyJkeEW/xu2sA1uNNCsjDOeWzHa1Hc5OFdToEJ9uf96RukvMbpMY05orBTXv0B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788619828; c=relaxed/simple;
	bh=59yjc7IrxD8OOWpUKmrGT3TptKW3inwU8k5cLEqfYeI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RrLjFsVOwa8Q9wmOOH1WEXoAx7OWyw7bXtW9zFuiNRitjgJbMFV9BFDvJ4Fstf+iYpdWFVMSRqgbizMv+aV/XtriDPGZGzbBubVGCjg3r23rMCTT8WbK1/u6ZxxDZ3OvyJcqIjYmLS022zYUSAV/7tt7N6/SfIi6X1OrT6vpm2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=sTWuu1tQ; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=f9hPMkDM; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="sTWuu1tQ";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="f9hPMkDM"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788619818; bh=aAYIQg5ciQhnSKgroaDb7DU
	c8/eehoCSG55Vu5dGjJE=; b=sTWuu1tQRsyaPdPicF65vX//PYolLBAbsxf825aB6xQCNl9bg+
	nxF3ETo7DJgWYWq2i/UtwWSkgbfgaTP2GbGKmp0tUXmFuj6puLZ5aDdCB0Ypy8HUlIuYIA9M79I
	jkaoS1lzHR0pTUNWHiQbPZSwgV48LxjARHRHSu4s1+Wdc5bcWmR5CyRstbI4fcGXiFHYzkZyDr9
	4cFYoe1L4uQNKiASSrR1be6UG4bgdc38ZyrTcRbREZ+VV3TpryjahOxBzdyJgrRkvV4eSb6mW7m
	RYE8DlTAemhwfOwT3tMG9dZ+CeNJfcAfnZaEv/wgw62wOS/EDVmInzKU01UO6hqWpYA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788619818; bh=aAYIQg5ciQhnSKgroaDb7DU
	c8/eehoCSG55Vu5dGjJE=; b=f9hPMkDMl5xV5LIokUesu+F70Vr99k0AjRmoSJFB4DK33URCkf
	DyhfSm7dYmftthe8Iaaz9YnvrAwppIeCcrBw==;
Date: Sat, 05 Sep 2026 15:50:16 +0100
From: Bradley Morgan <brads@mainlining.org>
To: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
CC: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Tejun Heo <tj@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Walls <awalls@md.metrocast.net>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 5/5] kthread: remove worker->task self assignment
In-Reply-To: <202609052214.xVrPcUI7-lkp@intel.com>
References: <c925e99c73bea9e0cdab656ba09453df7e81dcb2.1788513591.git.brads@mainlining.org> <202609052214.xVrPcUI7-lkp@intel.com>
Message-ID: <2DB23F9E-49A7-4CAC-8268-A62923E3D6E1@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 5 September 2026 15:37:16 BST, kernel test robot <lkp@intel.com> wrote:
>Hi Bradley,
>
>kernel test robot noticed the following build errors:
>
>[auto build test ERROR on tty/tty-testing]
>[also build test ERROR on tty/tty-next tty/tty-linus rafael-pm/linux-next
>rafael-pm/bleeding-edge brauner-vfs/vfs.all linus/master v7.3-rc1
>next-20260904]


Aware. Will fix.

>[If your patch is applied to the wrong git tree, kindly drop us a note.
>And when submitting patch, we suggest to use '--base' as documented in
>https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
>url:    https://github.com/intel-lab-lkp/linux/commits/Bradley-Morgan/media-ivtv-convert-to-kthread_run_worker/20260904-093753
>base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
>patch link:   
>https://lore.kernel.org/r/c925e99c73bea9e0cdab656ba09453df7e81dcb2.1788513591.git.brads%40mainlining.org
>patch subject: [PATCH v2 5/5] kthread: remove worker->task self assignment
>config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20260905/202609052214.xVrPcUI7-lkp@intel.com/config)
>compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 0edd1b088cc36b4faee80358c925a91e16006258)
>reproduce (this is a W=1 build):
>(https://download.01.org/0day-ci/archive/20260905/202609052214.xVrPcUI7-lkp@intel.com/reproduce)
>
>If you fix the issue in a separate patch/commit (i.e. not just a new
>version of
>the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes:
>https://lore.kernel.org/oe-kbuild-all/202609052214.xVrPcUI7-lkp@intel.com/
>
>All errors (new ones prefixed by >>):
>
>>> drivers/media/pci/ivtv/ivtv-irq.c:1053:22: error: incompatible pointer
>types passing 'struct kthread_worker **' to parameter of type 'struct
>kthread_worker *'; remove & [-Wincompatible-pointer-types]
>    1053 |                 kthread_queue_work(&itv->irq_worker, &itv->irq_work);
>         |                                    ^~~~~~~~~~~~~~~~
>   include/linux/kthread.h:263:48: note: passing argument to parameter 'worker' here
>     263 | bool kthread_queue_work(struct kthread_worker *worker,
>         |                                                ^
>   1 error generated.
>
>
>vim +1053 drivers/media/pci/ivtv/ivtv-irq.c
>
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27   917  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27   918  irqreturn_t ivtv_irq_handler(int irq, void *dev_id)
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27   919  {
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   920  	struct ivtv *itv = (struct ivtv *)dev_id;
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   921  	u32 combo;
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   922  	u32 stat;
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   923  	int i;
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   924  	u8 vsync_force = 0;
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27   925  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   926  	spin_lock(&itv->dma_reg_lock);
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   927  	/* get contents of irq status register */
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   928  	stat = read_reg(IVTV_REG_IRQSTATUS);
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27   929  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   930  	combo = ~itv->irqmask & stat;
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27   931  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   932  	/* Clear out IRQ */
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   933  	if (combo) write_reg(combo, IVTV_REG_IRQSTATUS);
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27   934  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   935  	if (0 == combo) {
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   936  		/* The vsync interrupt is unusual and clears itself. If we
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   937  		 * took too long, we may have missed it. Do some checks
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   938  		 */
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   939  		if (~itv->irqmask & IVTV_IRQ_DEC_VSYNC) {
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   940  			/* vsync is enabled, see if we're in a new field */
>4e1af31aaaa8cc drivers/media/video/ivtv/ivtv-irq.c Andy Walls    2010-03-13   941  			if ((itv->last_vsync_field & 1) !=
>4e1af31aaaa8cc drivers/media/video/ivtv/ivtv-irq.c Andy Walls    2010-03-13   942  			    (read_reg(IVTV_REG_DEC_LINE_FIELD) & 1)) {
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   943  				/* New field, looks like we missed it */
>4e1af31aaaa8cc drivers/media/video/ivtv/ivtv-irq.c Andy Walls    2010-03-13   944  				IVTV_DEBUG_YUV("VSync interrupt missed %d\n",
>4e1af31aaaa8cc drivers/media/video/ivtv/ivtv-irq.c Andy Walls    2010-03-13   945  				       read_reg(IVTV_REG_DEC_LINE_FIELD) >> 16);
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   946  				vsync_force = 1;
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   947  			}
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   948  		}
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27   949  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   950  		if (!vsync_force) {
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   951  			/* No Vsync expected, wasn't for us */
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   952  			spin_unlock(&itv->dma_reg_lock);
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   953  			return IRQ_NONE;
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   954  		}
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   955  	}
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27   956  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   957  	/* Exclude interrupts noted below from the output, otherwise the log is flooded with
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   958  	   these messages */
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   959  	if (combo & ~0xff6d0400)
>bd58df6d522d5a drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-07-10   960  		IVTV_DEBUG_HI_IRQ("======= valid IRQ bits: 0x%08x ======\n", combo);
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27   961  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   962  	if (combo & IVTV_IRQ_DEC_DMA_COMPLETE) {
>bd58df6d522d5a drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-07-10   963  		IVTV_DEBUG_HI_IRQ("DEC DMA COMPLETE\n");
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   964  	}
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27   965  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   966  	if (combo & IVTV_IRQ_DMA_READ) {
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   967  		ivtv_irq_dma_read(itv);
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   968  	}
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27   969  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   970  	if (combo & IVTV_IRQ_ENC_DMA_COMPLETE) {
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   971  		ivtv_irq_enc_dma_complete(itv);
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   972  	}
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27   973  
>dc02d50a6d71cb drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-05-19   974  	if (combo & IVTV_IRQ_ENC_PIO_COMPLETE) {
>dc02d50a6d71cb drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-05-19   975  		ivtv_irq_enc_pio_complete(itv);
>dc02d50a6d71cb drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-05-19   976  	}
>dc02d50a6d71cb drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-05-19   977  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   978  	if (combo & IVTV_IRQ_DMA_ERR) {
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   979  		ivtv_irq_dma_err(itv);
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   980  	}
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27   981  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   982  	if (combo & IVTV_IRQ_ENC_START_CAP) {
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   983  		ivtv_irq_enc_start_cap(itv);
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   984  	}
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27   985  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   986  	if (combo & IVTV_IRQ_ENC_VBI_CAP) {
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   987  		ivtv_irq_enc_vbi_cap(itv);
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   988  	}
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27   989  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   990  	if (combo & IVTV_IRQ_DEC_VBI_RE_INSERT) {
>dc02d50a6d71cb drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-05-19   991  		ivtv_irq_dec_vbi_reinsert(itv);
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   992  	}
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27   993  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   994  	if (combo & IVTV_IRQ_ENC_EOS) {
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   995  		IVTV_DEBUG_IRQ("ENC EOS\n");
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   996  		set_bit(IVTV_F_I_EOS, &itv->i_flags);
>fd8b281a2809d2 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-08-23   997  		wake_up(&itv->eos_waitq);
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27   998  	}
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27   999  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1000  	if (combo & IVTV_IRQ_DEC_DATA_REQ) {
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1001  		ivtv_irq_dec_data_req(itv);
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1002  	}
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27  1003  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1004  	/* Decoder Vertical Sync - We can't rely on 'combo', so check if vsync enabled */
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1005  	if (~itv->irqmask & IVTV_IRQ_DEC_VSYNC) {
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1006  		ivtv_irq_vsync(itv);
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1007  	}
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27  1008  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1009  	if (combo & IVTV_IRQ_ENC_VIM_RST) {
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1010  		IVTV_DEBUG_IRQ("VIM RST\n");
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1011  		/*ivtv_vapi(itv, CX2341X_ENC_REFRESH_INPUT, 0); */
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1012  	}
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27  1013  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1014  	if (combo & IVTV_IRQ_DEC_AUD_MODE_CHG) {
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1015  		IVTV_DEBUG_INFO("Stereo mode changed\n");
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1016  	}
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27  1017  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1018  	if ((combo & IVTV_IRQ_DMA) && !test_bit(IVTV_F_I_DMA, &itv->i_flags)) {
>33bc4dea0ece37 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-08-18  1019  		itv->irq_rr_idx++;
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1020  		for (i = 0; i < IVTV_MAX_STREAMS; i++) {
>33bc4dea0ece37 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-08-18  1021  			int idx = (i + itv->irq_rr_idx) % IVTV_MAX_STREAMS;
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1022  			struct ivtv_stream *s = &itv->streams[idx];
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27  1023  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1024  			if (!test_and_clear_bit(IVTV_F_S_DMA_PENDING, &s->s_flags))
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1025  				continue;
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1026  			if (s->type >= IVTV_DEC_STREAM_TYPE_MPG)
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1027  				ivtv_dma_dec_start(s);
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1028  			else
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1029  				ivtv_dma_enc_start(s);
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1030  			break;
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1031  		}
>b6e436b263b354 drivers/media/video/ivtv/ivtv-irq.c Ian Armstrong
>2009-12-21  1032  
>b6e436b263b354 drivers/media/video/ivtv/ivtv-irq.c Ian Armstrong 2009-12-21  1033  		if (i == IVTV_MAX_STREAMS &&
>b6e436b263b354 drivers/media/video/ivtv/ivtv-irq.c Ian Armstrong 2009-12-21  1034  		    test_bit(IVTV_F_I_UDMA_PENDING, &itv->i_flags))
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1035  			ivtv_udma_start(itv);
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1036  	}
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27  1037  
>dc02d50a6d71cb drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-05-19  1038  	if ((combo & IVTV_IRQ_DMA) && !test_bit(IVTV_F_I_PIO, &itv->i_flags)) {
>33bc4dea0ece37 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-08-18  1039  		itv->irq_rr_idx++;
>dc02d50a6d71cb drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-05-19  1040  		for (i = 0; i < IVTV_MAX_STREAMS; i++) {
>33bc4dea0ece37 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-08-18  1041  			int idx = (i + itv->irq_rr_idx) % IVTV_MAX_STREAMS;
>dc02d50a6d71cb drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-05-19  1042  			struct ivtv_stream *s = &itv->streams[idx];
>dc02d50a6d71cb drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-05-19  1043  
>dc02d50a6d71cb drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-05-19  1044  			if (!test_and_clear_bit(IVTV_F_S_PIO_PENDING, &s->s_flags))
>dc02d50a6d71cb drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-05-19  1045  				continue;
>dc02d50a6d71cb drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-05-19  1046  			if (s->type == IVTV_DEC_STREAM_TYPE_VBI || s->type < IVTV_DEC_STREAM_TYPE_MPG)
>dc02d50a6d71cb drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-05-19  1047  				ivtv_dma_enc_start(s);
>dc02d50a6d71cb drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-05-19  1048  			break;
>dc02d50a6d71cb drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-05-19  1049  		}
>dc02d50a6d71cb drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-05-19  1050  	}
>dc02d50a6d71cb drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-05-19  1051  
>2f3a98931f51be drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-08-25  1052  	if (test_and_clear_bit(IVTV_F_I_HAVE_WORK, &itv->i_flags)) {
>3989144f863ac5 drivers/media/pci/ivtv/ivtv-irq.c   Petr Mladek   2016-10-11 @1053  		kthread_queue_work(&itv->irq_worker, &itv->irq_work);
>2f3a98931f51be drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-08-25  1054  	}
>dc02d50a6d71cb drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-05-19  1055  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1056  	spin_unlock(&itv->dma_reg_lock);
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27  1057  
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1058  	/* If we've just handled a 'forced' vsync, it's safest to say it
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1059  	 * wasn't ours. Another device may have triggered it at just
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1060  	 * the right time.
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1061  	 */
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil  2007-04-27  1062  	return vsync_force ? IRQ_NONE : IRQ_HANDLED;
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27  1063  }
>1a0adaf37c30e8 drivers/media/video/ivtv/ivtv-irq.c Hans Verkuil 
>2007-04-27  1064  
>
>--
>0-DAY CI Kernel Test Service
>https://github.com/intel/lkp-tests/wiki

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
