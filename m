From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 0/2] serial: Add name field to uart_port
Date: Thu, 23 Mar 2017 17:52:46 +0530
Message-ID: <21173bda-55e5-b9d0-5eb1-335091fbca6a@ti.com>
References: <20170321133636.8814-1-vigneshr@ti.com>
 <CAHp75VdhHj-7Utganxo1YnSABmnM5KC+bVJe2KgXx65hNHNGng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHp75VdhHj-7Utganxo1YnSABmnM5KC+bVJe2KgXx65hNHNGng@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jisheng Zhang <jszhang@marvell.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org



On Thursday 23 March 2017 12:16 AM, Andy Shevchenko wrote:
> On Tue, Mar 21, 2017 at 3:36 PM, Vignesh R <vigneshr@ti.com> wrote:
>> This series adds name attribute to uart_port struct inorder to store
>> name of the tty port that will help in identify different uart
>> instances.
>> This patch series is based on discussion here[1].
> 
> Please, use versioning for the series. This AFAIU should be v3, and
> next (which is expecting based on comments) would be v4.

The very first patch I submitted was accepted. So I did not make the
previous patch as v2 as it was an incremental fix. Since, this series is
very different from previous patch, I chose not to label this as v3.
Anyways, will make the next version as v4.

Thanks for the review!


-- 
Regards
Vignesh
