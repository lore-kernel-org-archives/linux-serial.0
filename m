From: "dan carpenter" <error27@email.com>
Subject: 2.5.33 drivers/char/ dereference test
Date: Sat, 31 Aug 2002 23:56:26 -0500
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20020901045625.28999.qmail@email.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: smatch-kbugs@lists.sourceforge.net
Cc: R.E.Wolff@BitWizard.nl, linux-serial@vger.kernel.org

Smatch is an open source code checker under initial development.
(smatch.sf.net)

These potential errors were found using the 
http://smatch.sourceforge.net/scripts/dereference-test.pl.txt 
script and I have attempted to hand verify them.

"If you say " if (foo) { ... } foo->bar " then this script marks that as an error."

regards,
dan carpenter


===================================================
linux-2.5.33/drivers/char/amiserial.c
   459                          if (info->tty)
   460                                  tty_hangup(info->tty);
   461                  }
   462          }
   463          if (info->flags & ASYNC_CTS_FLOW) {
   464                  if (info->tty->hw_stopped) {
	(I'm not sure if this is an error.  It looks very suspicious
	if info->flags has both the ASYNC_CTS_FLOW and ASYNC_CHECK_CD
	bits set)


linux-2.5.33/drivers/char/epca.c
    78  #define epcaassert(x, msg)  if (!(x)) epca_error(__LINE__, msg)
	...
  2682          epcaassert(bc !=0, "bc out of range");
	...
  2692                  bc->rout = cmdHead;
	(epca_error() should probably be a panic rather than just printing 
         a msg)

linux-2.5.33/drivers/char/epca.c
  2862          if (tty)
  2863                  ts = tty->termios;
	...
  2899          if (tty->flip.count == TTY_FLIPBUF_SIZE) 
  2900                  return;


linux-2.5.33/drivers/char/generic_serial.c
   926          if ((!old_termios || 
   927               (old_termios->c_cflag & CRTSCTS)) &&
   928              !(      tiosp->c_cflag & CRTSCTS)) {
   929                  tty->stopped = 0;
   930                  gs_start(tty);
   931          }
   932  
   933  #ifdef tytso_patch_94Nov25_1726
   934          /* This "makes sense", Why is it commented out? */
   935  
   936          if (!(old_termios->c_cflag & CLOCAL) &&
   937              (tty->termios->c_cflag & CLOCAL))
   938                  wake_up_interruptible(&info->open_wait);
	(The script didn't actually find this bug because it is ifdef out.
	I happenned to notice it while looking at false positives.  I should
	be something like if (old_termios && !(old_termios->c_cflag & CLOCAL) 
	&& ...) )


linux-2.5.33/drivers/char/synclink.c
  1382                                  if (info->tty)
  1383                                          tty_hangup(info->tty);
  1384                          }
  1385                  }
  1386          
  1387                  if ( (info->flags & ASYNC_CTS_FLOW) && 
  1388                       (status & MISCSTATUS_CTS_LATCHED) ) {
  1389                          if (info->tty->hw_stopped) {
	(I'm not sure if this is an error.  It looks very suspicious
	if info->flags has both the ASYNC_CTS_FLOW and ASYNC_CHECK_CD
	bits set)


-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

