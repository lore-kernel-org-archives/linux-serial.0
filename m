From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V2 2/6] tty: serial: lpuart: add little endian 32 bit
 register support
Date: Mon, 15 May 2017 16:36:25 +0300
Message-ID: <CAHp75VeGKzDfwi1zMz+u5WZWmqnJkE41n8gw+uWcce8ngXrm2w@mail.gmail.com>
References: <1494834539-17523-1-git-send-email-aisheng.dong@nxp.com>
 <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: fugang.duan@nxp.com, dongas86@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, yangbo.lu@nxp.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>, Mingkai.Hu@nxp.com, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Mon, May 15, 2017 at 10:48 AM, Dong Aisheng <aisheng.dong@nxp.com> wrote:
> It's based on the exist lpuart32 read/write implementation.

Same as per previous comment (perhaps not in other UART driver, but
some might have been using device property for that.


-- 
With Best Regards,
Andy Shevchenko
