import re
import subprocess

gmail_mapping = { 'INBOX'       : 'inbox'
          , '[Gmail]/All Mail'  : 'archive'
          , '[Gmail]/Drafts'    : 'drafts'
          , '[Gmail]/Important' : 'important'
          , '[Gmail]/Sent Mail' : 'sent'
          , '[Gmail]/Spam'      : 'spam'
          , '[Gmail]/Starred'   : 'starred'
          , '[Gmail]/Trash'     : 'trash'
          }

r_gmail_mapping = { val: key for key, val in gmail_mapping.items() }

def gmail_remote_nt(folder):
    return gmail_mapping.get(folder, folder)

def gmail_local_nt(folder):
    return r_gmail_mapping.get(folder, folder)

# folderfilter = exclude(['Label', 'Label', ... ])
def exclude(excludes):
    def inner(folder):
        try:
            excludes.index(folder)
            return False
        except:
            return True

    return inner

def client_id(account):
  cmd = ["cat", "/home/david/.offlineimap/%s/client_id" % account]
  try:
      return subprocess.check_output(cmd).strip()
  except subprocess.CalledProcessError:
      return ""

def client_secret(account):
  cmd = ["cat", "/home/david/.offlineimap/%s/client_secret" % account]
  try:
      return subprocess.check_output(cmd).strip()
  except subprocess.CalledProcessError:
      return ""

def refresh_token(account):
  cmd = ["cat", "/home/david/.offlineimap/%s/refresh_token" % account]
  try:
      return subprocess.check_output(cmd).strip()
  except subprocess.CalledProcessError:
      return ""

def get_pass(address):
  args = ["pass", "mail/%s" % address]
  try:
    return subprocess.check_output(args).strip().splitlines()[0]
  except subprocess.CalledProcessError:
    return ""

# yandex_mapping = { 'INBOX'                       : 'Inbox'
#           , '&BCcENQRABD0EPgQyBDgEOgQ4-'         : 'Drafts'
#           , '&BB4EQgQ,BEAEMAQyBDsENQQ9BD0ESwQ1-' : 'Sent'
#           , '&BCEEPwQwBDw-'                      : 'Spam'
#           , '&BCMENAQwBDsENQQ9BD0ESwQ1-'         : 'Trash'
# # not fully sure about starred
#           , '&BBgEQQRFBD4ENARPBEkEOAQ1-'         : 'Starred'
#           }

# r_yandex_mapping = { val: key for key, val in yandex_mapping.items() }

# def yandex_remote_nt(folder):
#     return yandex_mapping.get(folder, folder)

# def yandex_local_nt(folder):
#     return r_yandex_mapping.get(folder, folder)
