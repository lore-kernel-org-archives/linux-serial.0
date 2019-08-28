From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: mmotm 2019-08-24-16-02 uploaded
 (drivers/tty/serial/fsl_linflexuart.c:)
Date: Tue, 27 Aug 2019 18:14:32 -0700
Message-ID: <b082b200-7298-6cd5-6981-44439bc2d788@infradead.org>
References: <20190824230323.REILuVBbY%akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190824230323.REILuVBbY%akpm@linux-foundation.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, broonie@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz, mm-commits@vger.kernel.org, sfr@canb.auug.org.au, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fugang Duan <fugang.duan@nxp.com>
List-Id: linux-serial@vger.kernel.org

On 8/24/19 4:03 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2019-08-24-16-02 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.
> 
> This tree is partially included in linux-next.  To see which patches are
> included in linux-next, consult the `series' file.  Only the patches
> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> linux-next.

on i386:
when CONFIG_PRINTK is not set/enabled:

../drivers/tty/serial/fsl_linflexuart.c: In function ‘linflex_earlycon_putchar’:
../drivers/tty/serial/fsl_linflexuart.c:608:31: error: ‘CONFIG_LOG_BUF_SHIFT’ undeclared (first use in this function); did you mean ‘CONFIG_DEBUG_SHIRQ’?
  if (earlycon_buf.len >= 1 << CONFIG_LOG_BUF_SHIFT)
                               ^~~~~~~~~~~~~~~~~~~~
                               CONFIG_DEBUG_SHIRQ


-- 
~Randy
