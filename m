From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] serial: sh-sci: Missing uart_unregister_driver() on
 error in sci_probe_single()
Date: Mon, 11 Mar 2019 15:46:16 +0300
Message-ID: <20190311124616.GE2412@kadam>
References: <20190311095115.156774-1-maowenan@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311095115.156774-1-maowenan@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mao Wenan <maowenan@huawei.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 11, 2019 at 05:51:15PM +0800, Mao Wenan wrote:
> Add the missing uart_unregister_driver() before return
> from sci_probe_single() in the error handling case.
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---

Sorry, I didn't really look at the code when I saw the v1 patch.

There are other error paths, but actually the whole approach is wrong.
Please, read my google plus post about error handling:

https://plus.google.com/u/0/106378716002406849458/posts/1Ud9JbaYnPr

But then the other rule I didn't mention in that post which applies
here is that the error handling should "mirror" the allocation code
so if you have:

	if (foo) {
		ret = allocate_one();
		if (ret)
			return ret;
	}
	ret = allocate_two();
	if (ret)
		goto free_one;

The error handling should mirror the "if (foo) " condition.  Like this:

free_one:
	if (foo)
		free_one();

Even if you can do extra analysis and find that the "if (foo) " can
be removed, you should leave there, because the mirroring helps human
readers.

In this case, the code is doing:

drivers/tty/serial/sh-sci.c
  3259                  return -EBUSY;
  3260  
  3261          mutex_lock(&sci_uart_registration_lock);
  3262          if (!sci_uart_driver.state) {
                    ^^^^^^^^^^^^^^^^^^^^^^
  3263                  ret = uart_register_driver(&sci_uart_driver);
  3264                  if (ret) {
  3265                          mutex_unlock(&sci_uart_registration_lock);
  3266                          return ret;
  3267                  }
  3268          }
  3269          mutex_unlock(&sci_uart_registration_lock);
  3270  

We would have to mirror the "if (!sci_uart_driver.state) {" code.

But actually, we can't.

The first driver to hit this code is supposed to load the
sci_uart_driver.  We can't know if we are the last driver to stop using
the sci_uart_driver so we can't know if we can free it.  This looks like
a very ugly hack to me.  It should probably be using ref counters.

regards,
an carpenter
