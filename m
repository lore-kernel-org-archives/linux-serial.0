From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch 1/2] staging: dgnc: some off by one bugs
Date: Thu, 12 Mar 2015 20:19:26 +0300
Message-ID: <20150312171926.GM16501@mwanda>
References: <20150312170739.GA21911@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20150312170739.GA21911@mwanda>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Lidza Louina <lidza.louina@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, kernel-janitors@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 12, 2015 at 08:07:39PM +0300, Dan Carpenter wrote:
> "dgnc_NumBoards" is the number of filled out elements in the
> dgnc_Board[] array.  "->nasync" and "->maxports" are the value.

I meant "the *same* value".  I'll resend.

regards,
dan carpenter
